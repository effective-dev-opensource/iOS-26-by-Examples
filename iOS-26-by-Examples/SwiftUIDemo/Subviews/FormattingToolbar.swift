import SwiftUI

struct FormattingToolbar: View {
    @Environment(\.fontResolutionContext) var fontResolutionContext

    @Binding var isBold: Bool
    @Binding var isItalic: Bool
    @Binding var fontSize: Double
    @Binding var textColor: Color
    @Binding var richText: AttributedString
    @Binding var selection: AttributedTextSelection


    var body: some View {
        HStack(spacing: 16) {
            ToggleButton(
                title: "B",
                isSelected: $isBold,
                font: .headline.bold()
            ) {
                richText.transformAttributes(in: &selection) { container in
                    let currentFont = container.font ?? .default
                    let resolved = currentFont.resolve(in: fontResolutionContext)
                    container.font = currentFont.bold(!resolved.isBold)
                }
            }

            ToggleButton(
                title: "I",
                isSelected: $isItalic,
                font: .headline.italic()
            ) {
                richText.transformAttributes(in: &selection) { container in
                    let currentFont = container.font ?? .default
                    let resolved = currentFont.resolve(in: fontResolutionContext)
                    container.font = currentFont.italic(!resolved.isItalic)
                }
            }

            VStack {
                Text("Size")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Stepper(value: $fontSize, in: 12...24, step: 1) {}
                    .labelsHidden()
            }
            .cornerRadius(16)

            ColorPicker("Color", selection: $textColor)
                .labelsHidden()
        }
        .padding(.horizontal)
        .cornerRadius(16)
    }
}
