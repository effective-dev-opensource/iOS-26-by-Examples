import FoundationModels

@Generable
struct RouteResponse: Codable {
    @Guide(description: "Order of landmark names for optimal visit")
    let order: [String]
    @Guide(description: "Description of the route and estimated walking times")
    let description: String
}
