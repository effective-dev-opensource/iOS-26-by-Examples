import SwiftUI

struct FloatingActionButton: View {
    @Binding var isPressed: Bool

    var body: some View {
        Button {
            withAnimation(.bouncy) {
                isPressed.toggle()
            }
        } label: {
            Image(systemName: isPressed ? "checkmark" : "plus")
                .font(.title2)
                .frame(width: 56, height: 56)
                .background(.blue.gradient)
                .foregroundColor(.white)
                .clipShape(Circle())
                .glassEffect(in: .circle)
                .scaleEffect(isPressed ? 1.1 : 1.0)
        }
    }
}
