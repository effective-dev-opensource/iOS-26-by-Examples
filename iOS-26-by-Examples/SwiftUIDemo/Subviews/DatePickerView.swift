import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date

    var body: some View {
        DatePicker("Date", selection: $date, displayedComponents: .date)
            .datePickerStyle(.compact)
    }
}
