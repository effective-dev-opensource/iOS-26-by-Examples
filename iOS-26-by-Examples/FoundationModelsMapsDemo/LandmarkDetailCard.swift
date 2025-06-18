import SwiftUI

struct LandmarkDetailCard: View {
    let landmark: Landmark
    let onClose: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(landmark.name)
                    .font(.title2).bold()
                Spacer()
                Button {
                    onClose()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            if let desc = landmark.description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
            }
            HStack(spacing: 12) {
                Label(String(format: "%.5f", landmark.latitude), systemImage: "location")
                    .font(.caption)
                Label(String(format: "%.5f", landmark.longitude), systemImage: "location.north")
                    .font(.caption)
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 10)
    }
}
