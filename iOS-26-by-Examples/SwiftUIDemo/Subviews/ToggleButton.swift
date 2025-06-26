import SwiftUI

struct ToggleButton: View {
    let title: String
    @Binding var isSelected: Bool
    let font: Font
    let buttonAction: () -> Void

    var body: some View {
        Button(title) {
            isSelected.toggle()
            buttonAction()
        }
        .font(font)
        .frame(width: 32, height: 32)
        .background(isSelected ? Color.accentColor : .clear)
        .foregroundStyle(isSelected ? .white : .primary)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.quaternary, lineWidth: 1)
        )
    }
}
