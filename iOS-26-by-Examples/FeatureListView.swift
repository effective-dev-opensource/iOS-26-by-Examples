import SwiftUI

struct FeatureListView: View {
    private let features = DataSource.features
    var body: some View {
        NavigationStack {
            List(features) { feature in
                NavigationLink {
                    DataSource.destination(for: feature)
                } label: {
                    Label(feature.title, systemImage: feature.systemImage)
                }
            }
            .navigationTitle("iOS 26 Examples")
        }
    }
}

#Preview {
    FeatureListView()
}
