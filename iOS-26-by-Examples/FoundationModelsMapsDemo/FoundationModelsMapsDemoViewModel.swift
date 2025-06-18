import SwiftUI
import MapKit
import Combine

class FoundationModelsMapsDemoViewModel: ObservableObject {
    let foundationModelService = FoundationModelService()
    let mapRoutingService = MapRoutingService()

    @Published var landmarks: [Landmark] = []
    @Published var isLoading = false
    @Published var routeDescription: String?
    @Published var selectedLandmark: Landmark? = nil
    @Published var route: [CLLocationCoordinate2D] = []

    func generateLandmarks() {
        resetState()

        Task {
            do {
                let lm = try await foundationModelService.generateLandmarks()
                await MainActor.run {
                    self.landmarks = lm
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }

    func generateRoute() {
        guard landmarks.count > 0 else {
            return
        }

        resetState(clearRoute: false)

        Task {
            do {
                let names = landmarks.map(\.name)
                let response = try await foundationModelService.generateRouteDescription(for: names)

                let ordered = response.order.compactMap { name in
                    landmarks.first {
                        $0.name == name
                    }
                }

                let coords = try await mapRoutingService.calculateWalkingRoute(landmarks: ordered)

                await MainActor.run {
                    self.route = coords
                    self.routeDescription = response.description
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }

    private func resetState(clearRoute: Bool = true) {
        isLoading = true
        routeDescription = nil
        if clearRoute {
            route = []
        }
    }
}
