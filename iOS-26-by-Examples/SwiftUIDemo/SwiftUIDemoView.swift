import SwiftUI

struct SwiftUIDemoView: View {
    @StateObject private var viewModel = SwiftUIDemoViewModel()

    var body: some View {
        TabView {
            Tab("Liquid Glass", systemImage: "sparkles") {
                NavigationStack {
                    LiquidGlassView(viewModel: viewModel)
                }
            }

        }
        .tabViewStyle(.sidebarAdaptable)
    }
}
