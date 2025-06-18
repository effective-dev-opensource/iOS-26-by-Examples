import FoundationModels

class FoundationModelService {
    private let session = LanguageModelSession()

    func generateLandmarks() async throws -> [Landmark] {
        let prompt = """
        Generate 4-6 famous tourist places in Paris, France with:
        - Precise name
        - Short description (1 sentence)
        - Exact coordinates (latitude, longitude)
        Return as a valid Landmark array.
        """
        let response = try await session.respond(to: prompt, generating: [Landmark].self)
        return response.content
    }

    func generateRouteDescription(for placeNames: [String]) async throws -> RouteResponse {
        let list = placeNames.joined(separator: ", ")
        let prompt = """
        Given these Paris landmarks: [\(list)], 
        generate an optimal walking route considering:
        - Geographical proximity
        - Logical sightseeing flow
        - Tourist preferences
        
        Return a JSON object with:
        - "order": array of landmark names in optimal visit order
        - "description": text description of the route with estimated walking times
        """
        let response = try await session.respond(to: prompt, generating: RouteResponse.self)
        return response.content
    }
}
