import SwiftUI

struct Feature: Identifiable {
    let id = UUID()
    let title: String
    let systemImage: String
}

enum DataSource {
    private static let items: [(feature: Feature, destination: AnyView)] = [
        (
            Feature(title: "FoundationModels + MapKit", systemImage: "map"),
            AnyView(FoundationModelsMapsDemoView())
        ),
        (
            Feature(title: "WebKit", systemImage: "safari"),
            AnyView(WebPageDemo())
        ),
        (
            Feature(title: "SwiftUI", systemImage: "swift"),
            AnyView(SwiftUIDemoView())
        ),
        (
            Feature(title: "PaperKit", systemImage: "pencil.and.outline"),
            AnyView(PaperKitViewControllerRepresentable())
        ),
    ]

    static var features: [Feature] { items.map { $0.feature } }

    static func destination(for feature: Feature) -> AnyView {
        guard let match = items.first(where: { $0.feature.id == feature.id }) else {
            return AnyView(EmptyView())
        }
        return match.destination
    }
}
