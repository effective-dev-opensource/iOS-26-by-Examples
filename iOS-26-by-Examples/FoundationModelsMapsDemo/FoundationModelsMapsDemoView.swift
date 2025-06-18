import SwiftUI

struct FoundationModelsMapsDemoView: View {
    @StateObject private var viewModel = FoundationModelsMapsDemoViewModel()

    var body: some View {
        NavigationStack {
            MapSectionView(viewModel: viewModel)
                .frame(height: 360)
                .padding(.top)
                .padding(.horizontal)

            HStack(spacing: 12) {
                ActionButton(
                    title: viewModel.isLoading ? "Generation..." : "Interesting places",
                    icon: "wand.and.stars",
                    action: viewModel.generateLandmarks,
                    disabled: viewModel.isLoading,
                    prominent: true
                )

                ActionButton(
                    title: viewModel.isLoading ? "Construction..." : "Optimal route",
                    icon: "map",
                    action: viewModel.generateRoute,
                    disabled: viewModel.isLoading || viewModel.landmarks.count < 2
                )
            }
            .padding(.horizontal)
            .padding(.top)

            ScrollViewReader { _ in
                List {
                    if let description = viewModel.routeDescription {
                        Section {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "map.fill")
                                        .foregroundColor(.blue)
                                    Text("Your Route")
                                        .font(.headline)
                                }

                                Text(description)
                                    .font(.subheadline)
                                    .padding(.top)
                            }
                            .padding(.top)
                        }
                    }

                    Section("All Attractions") {
                        ForEach(viewModel.landmarks) { landmark in
                            LandmarkRow(landmark: landmark)
                                .padding(.vertical, 6)
                        }
                    }
                }
                .padding(.vertical)
            }
            .padding(.vertical)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Paris Explorer")
    }
}
