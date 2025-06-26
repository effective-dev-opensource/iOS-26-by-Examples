import SwiftUI

struct AnimatableCircleView: View {
    @Binding var isExpandedCircle: Bool

    var body: some View {
        VStack(spacing: 12) {
            AnimatableCircle(radius: isExpandedCircle ? 100 : 50)
                .fill(.blue.gradient)
                .frame(width: 220, height: 220)
                .animation(.easeInOut(duration: 1.2), value: isExpandedCircle)

            Button(isExpandedCircle ? "Compress" : "Expand") {
                isExpandedCircle.toggle()
            }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
        }
    }
}

@Animatable
struct AnimatableCircle: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addEllipse(in: CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: radius * 2,
                height: radius * 2
            ))
        }
    }
}
