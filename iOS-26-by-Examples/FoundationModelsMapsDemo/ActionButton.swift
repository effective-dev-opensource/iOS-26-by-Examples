import SwiftUI

struct ActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    let disabled: Bool
    var prominent: Bool = false

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(disabled ? .gray.opacity(0.3) : (prominent ? .blue : Color(.systemFill)))
            .foregroundColor(disabled ? .gray : (prominent ? .white : .primary))
            .cornerRadius(10)
        }
        .disabled(disabled)
    }
}
