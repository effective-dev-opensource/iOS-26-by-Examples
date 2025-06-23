import WebKit

final class JavaScriptMessageHandler: NSObject, WKScriptMessageHandler {
    private let onMessage: (String, [String: Any]) -> Void

    init(onMessage: @escaping (String, [String: Any]) -> Void) {
        self.onMessage = onMessage
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let body = message.body as? [String: Any] {
            onMessage(message.name, body)
        } else {
            onMessage(message.name, [:])
        }
    }
}
