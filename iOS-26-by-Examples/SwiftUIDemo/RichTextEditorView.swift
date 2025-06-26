import SwiftUI

struct RichTextEditorView: View {
    @StateObject var viewModel: SwiftUIDemoViewModel

    var body: some View {
        VStack(spacing: 16) {
            FormattingToolbar(
                isBold: $viewModel.isBold,
                isItalic: $viewModel.isItalic,
                fontSize: $viewModel.fontSize,
                textColor: $viewModel.textColor,
                richText: $viewModel.richText,
                selection: $viewModel.selection
            )

            TextEditor(text: $viewModel.richText, selection: $viewModel.selection)
                .font(.system(size: viewModel.fontSize))
                .foregroundColor(viewModel.textColor)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.quaternary, lineWidth: 1)
                )

            StatusBar(
                richText: viewModel.richText,
                wordCount: viewModel.wordCount(from: viewModel.richText)
            ) {
                viewModel.richText = AttributedString("")
            }
        }
        .padding()
    }
}
