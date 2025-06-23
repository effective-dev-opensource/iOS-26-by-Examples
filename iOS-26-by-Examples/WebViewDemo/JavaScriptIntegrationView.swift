import SwiftUI
import WebKit

struct JavaScriptIntegrationView: View {
    @StateObject var viewModel: WebPageDemoViewModel

    var body: some View {
        VStack {
            WebView(viewModel.webPage)

            Button("Display random number") {
                viewModel.handleRandomRequest()
            }
            .buttonStyle(.borderedProminent)

            if let nativeMessage = viewModel.nativeMessage {
                Text("Obtained value: \(nativeMessage)")
            }
        }
        .padding()
        .onAppear {
            viewModel.loadPageHTML(nameFile: "js_demo")
        }
    }
}
