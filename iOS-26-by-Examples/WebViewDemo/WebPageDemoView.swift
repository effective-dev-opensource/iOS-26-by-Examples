import SwiftUI
import WebKit

struct WebPageDemoView: View {
    @StateObject var viewModel: WebPageDemoViewModel

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                WebView(viewModel.webPage)
                    .findNavigator(isPresented: $viewModel.showingFind)
                    .webViewMagnificationGestures(.enabled)
                    .ignoresSafeArea(.container, edges: .bottom)
            }
        }
        .navigationTitle(viewModel.webPage.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadURL(viewModel.webKitDocs)
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                    .disabled(viewModel.isGoBack)

                    Button {
                        viewModel.goForward()
                    } label: {
                        Image(systemName: "arrow.forward")
                    }
                    .disabled(viewModel.isGoForward)

                    Button {
                        viewModel.reload()
                    } label: {
                        Image(systemName: "arrow.circlepath")
                    }

                    Button {
                        viewModel.showingFind.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
    }
}
