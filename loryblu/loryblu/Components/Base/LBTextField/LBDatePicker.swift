import SwiftUI

struct LBDatePicker: View {
    let onConfirm: (Date) -> Void
    let onCancel: () -> Void
    @Environment(\.dismiss) var dismiss
    @State var selectedDate = Date()
    var body: some View {

        ZStack(alignment: .center ) {
            VStack {
                DatePicker(LBStrings.Register.birthDay, selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .padding()
                                .background(Color.white.cornerRadius(20))
                                .clipped()
                                .environment(\.locale, Locale.init(identifier: "pt"))
                                .foregroundColor(LBColor.background)
                            .padding(20)
                HStack {
                    Button(LBStrings.General.confirm) {
                        onConfirm(selectedDate)
                        dismiss()
                    }
                    Button(LBStrings.General.cancel) {
                        onCancel()
                        dismiss()
                    }
                }
            }
        }
    }
}

struct LBDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        LBDatePicker { date in

        } onCancel: {

        }
    }
}
