import SwiftUI

struct GlassPickers: View {
    @Binding var selectedOption: String
    let options: [String]

    var body: some View {
        VStack(spacing: 12) {
            Text("Glass Picker")
                .font(.headline)
            Picker("Options", selection: $selectedOption) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.segmented)

            Picker("Choice", selection: $selectedOption) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.menu)
        }
        .padding()
        .glassEffect(in: .containerRelative)
    }
}
