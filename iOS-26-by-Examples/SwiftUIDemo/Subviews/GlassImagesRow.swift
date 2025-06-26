import SwiftUI

struct GlassImagesRow: View {
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(spacing: 12) {
            GlassEffectContainer(spacing: 40) {
                HStack(spacing: 40) {
                    Image(systemName: "scribble.variable")
                        .font(.system(size: 36))
                        .glassEffect()
                    if isExpanded {
                        Image(systemName: "eraser.fill")
                            .font(.system(size: 36))
                            .glassEffect()
                    }
                }
            }

            Button("Toggle") {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            .buttonStyle(.glass)
        }
    }
}
