import SwiftUI

struct GlassSlider: View {
    @Binding var sliderValue: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Glass Slider: \(Int(sliderValue))")
                .font(.subheadline)
            Slider(value: $sliderValue, in: 0...100)
        }
        .padding()
        .glassEffect(in: .containerRelative)
    }
}
