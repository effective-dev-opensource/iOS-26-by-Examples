import MapKit
import SwiftUI

struct MapSectionView: View {
    @ObservedObject var viewModel: FoundationModelsMapsDemoViewModel

    var body: some View {
        ZStack(alignment: .top) {
            Map {
                annotations
                routePolyline
            }
            .clipShape(RoundedRectangle(cornerRadius: 18))

            if let selected = viewModel.selectedLandmark {
                VStack {
                    Spacer()
                    LandmarkDetailCard(landmark: selected) {
                        withAnimation {
                            viewModel.selectedLandmark = nil
                        }
                    }
                }
                .transition(.opacity.combined(with: .blurReplace))
                .padding(.bottom, 8)
                .padding(.horizontal)
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    private var annotations: some MapContent {
        ForEach(viewModel.landmarks) { landmark in
            Annotation(landmark.name, coordinate: landmark.coordinate) {
                Button {
                    withAnimation { viewModel.selectedLandmark = landmark }
                } label: {
                    ZStack {
                        Circle()
                            .fill(viewModel.selectedLandmark == landmark ? Color.accentColor : .blue)
                            .frame(width: 32, height: 32)
                            .shadow(radius: 8)
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                    }
                }
                .accessibilityLabel(landmark.name)
            }
        }
    }

    private var routePolyline: some MapContent {
        Group {
            if viewModel.route.count > 1 {
                MapPolyline(coordinates: viewModel.route)
                    .stroke(Color.accentColor, lineWidth: 4)
            }
        }
    }
}
