import FoundationModels
import Foundation
import MapKit

@Generable
struct Landmark: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    @Guide(description: "Place name")
    let name: String
    @Guide(description: "Brief description")
    let description: String?
    @Guide(description: "Latitude coordinate")
    let latitude: Double
    @Guide(description: "Longitude coordinate")
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
