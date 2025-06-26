import SwiftUI

struct ModalButtons: View {
    @Binding var showSheet: Bool
    @Binding var showPopover: Bool
    @Binding var showAlert: Bool

    var body: some View {
        VStack(spacing: 12) {
            Button("Show Sheet") {
                showSheet.toggle()
            }
            .buttonStyle(.bordered)

            Button("Show Popover") {
                showPopover.toggle()
            }
            .buttonStyle(.bordered)

            Button("Alert") {
                showAlert.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
}
