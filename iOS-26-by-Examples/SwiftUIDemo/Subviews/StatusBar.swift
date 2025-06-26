import SwiftUI

struct StatusBar: View {
    let richText: AttributedString
    let wordCount: Int
    let clearAction: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Symbols: \(richText.characters.count)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("Words: \(wordCount)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button("Clear", action: clearAction)
                .buttonStyle(.bordered)
                .controlSize(.small)
        }
        .padding(.horizontal)
    }
}
