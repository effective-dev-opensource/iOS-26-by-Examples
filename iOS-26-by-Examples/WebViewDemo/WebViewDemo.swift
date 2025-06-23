import SwiftUI
import WebKit
import Combine

struct WebPageDemo: View {
    @StateObject private var viewModel = WebPageDemoViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section("Main features") {
                    NavigationLink("Basic WebView",
                                   destination: WebPageDemoView(viewModel: viewModel))
                }
            }
            .navigationTitle("WebView")
        }
    }
}
