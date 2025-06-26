import SwiftUI
import Combine

final class SwiftUIDemoViewModel: ObservableObject {
    @Published var sliderValue: Double = 50
    @Published var selectedOption: String = "Option 1"
    @Published var date: Date = Date()
    @Published var isPressed: Bool = false
    @Published var isExpanded: Bool = false
    @Published var isExpandedCircle: Bool = false
    @Published var showSheet: Bool = false
    @Published var showPopover: Bool = false
    @Published var showAlert: Bool = false

    let options = ["Option 1", "Option 2", "Option 3"]

    @Published var richText = AttributedString("")
    @Published var selection = AttributedTextSelection()
    @Published var isBold = false
    @Published var isItalic = false
    @Published var textColor: Color = .primary
    @Published var fontSize: Double = 16

    func wordCount(from attributedString: AttributedString) -> Int {
        let string = String(attributedString.characters)
        return string.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .count
    }
}
