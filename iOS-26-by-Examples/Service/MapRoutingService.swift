import MapKit

class MapRoutingService {
    func calculateWalkingRoute(landmarks: [Landmark]) async throws -> [CLLocationCoordinate2D] {
        guard landmarks.count >= 2 else { return [] }

        var allCoordinates: [CLLocationCoordinate2D] = []

        for i in 0..<(landmarks.count - 1) {
            let start = landmarks[i].coordinate
            let end = landmarks[i+1].coordinate

            let route = try await calculateRouteSegment(from: start, to: end)
            allCoordinates.append(contentsOf: route.polyline.coordinates)
        }

        return allCoordinates
    }

    private func calculateRouteSegment(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) async throws -> MKRoute {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .walking
        request.requestsAlternateRoutes = false

        let directions = MKDirections(request: request)
        let response = try await directions.calculate()

        guard let route = response.routes.first else {
            return MKRoute()
        }

        return route
    }
}

extension MKMultiPoint {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid,
                                              count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}
