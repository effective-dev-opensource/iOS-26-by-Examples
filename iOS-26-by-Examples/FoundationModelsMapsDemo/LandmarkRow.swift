import SwiftUI

struct LandmarkRow: View {
    let landmark: Landmark

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(landmark.name)
                .font(.headline)

            if let desc = landmark.description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            HStack(spacing: 16) {
                Label(String(format: "%.5f", landmark.latitude), systemImage: "location")
                Label(String(format: "%.5f", landmark.longitude), systemImage: "location.north")
            }
            .padding(.top, 4)
        }
        .padding(.vertical, 8)
    }
}
