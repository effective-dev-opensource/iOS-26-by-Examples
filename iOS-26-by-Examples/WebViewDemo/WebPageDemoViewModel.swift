import WebKit
import Combine

final class WebPageDemoViewModel: ObservableObject {
    let webPage: WebPage

    @Published var isLoading = true
    @Published var isGoBack = true
    @Published var isGoForward = true
    @Published var showingFind = false
    @Published var currentEvent: WebPage.NavigationEvent?
    @Published var nativeMessage: String?

    let webKitDocs = URL(string: "https://developer.apple.com/documentation/webkit")!
    private let configuration: WebPage.Configuration
    private var messageHandler: JavaScriptMessageHandler?

    init() {
        configuration = WebPage.Configuration()
        webPage = WebPage(configuration: configuration)
        configurationWebPage()

        Task {
            await observeNavigationEvents()
        }
    }

    func loadURL(_ url: URL?) {
        guard let url = url else { return }
        webPage.load(URLRequest(url: url))
    }

    func loadPageHTML(nameFile: String) {
        guard let url = Bundle.main.url(forResource: nameFile, withExtension: "html") else { return }
        self.loadURL(url)
    }

    func goBack() {
        isLoading = true
        self.loadURL(webPage.backForwardList[-1]?.url)
    }

    func goForward() {
        isLoading = true
        self.loadURL(webPage.backForwardList[1]?.url)
    }

    func reload() {
        webPage.reload()
    }

    func handleNativeMessage(_ body: [String: Any]) {
        if let _ = body["action"] as? String,
           let payload = body["payload"] as? String {
            let jsResponse = "document.getElementById('nativeResponse').innerText = '\(payload)!';"
            self.nativeMessage = payload
            self.executeJavaScript(jsResponse)
        }
    }

    func handleRandomRequest() {
        let randomNumber = Int.random(in: 1...100)
        let jsResponse = "updateFromSwift(\(randomNumber))"
        executeJavaScript(jsResponse)
    }

    private func configurationWebPage() {
        messageHandler = JavaScriptMessageHandler { [weak self] name, body in
            DispatchQueue.main.async {
                switch name {
                case "nativeHandler":
                    self?.handleNativeMessage(body)
                case "requestRandom":
                    self?.handleRandomRequest()
                default:
                    break
                }
            }
        }

        if let handler = messageHandler {
            configuration.userContentController.add(handler, name: "nativeHandler")
            configuration.userContentController.add(handler, name: "requestRandom")
        }
    }

    private func executeJavaScript(_ jsResponse: String) {
        Task {
            try? await webPage.callJavaScript(jsResponse)
        }
    }

    private func observeNavigationEvents() async {
        let navigationStream = AsyncStream<WebPage.NavigationEvent?> { continuation in
            startObserving(continuation)
        }

        for await event in navigationStream {
            if let event = event {
                await MainActor.run {
                    navigationEvent(event.kind)
                }
            }
        }
    }

    private func startObserving(_ continuation: AsyncStream<WebPage.NavigationEvent?>.Continuation) {
        withObservationTracking {
            webPage.currentNavigationEvent
        } onChange: {
            Task { @MainActor in
                continuation.yield(self.webPage.currentNavigationEvent)
                self.startObserving(continuation)
            }
        }
    }

    private func navigationEvent(_ kind: WebPage.NavigationEvent.Kind) {
        switch kind {
        case .committed:
            isGoBack = webPage.backForwardList.backList.isEmpty
            isGoForward = webPage.backForwardList.forwardList.isEmpty
        case .finished:
            isLoading = false
        case .failed:
            isLoading = false
        default:
            break
        }
    }
}
