import SwiftUI

struct LBDatePicker: View {
    let onConfirm: (Date) -> Void
    let onCancel: () -> Void
    @Environment(\.dismiss) var dismiss
    @State var selectedDate = Date()
    var body: some View {
        Color.gray.opacity(0.2)
            .ignoresSafeArea()
            .overlay {
                VStack {
                    DatePicker(LBStrings.Register.birthDay, selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                        .background(Color.white.cornerRadius(20))
                        .frame(width: 350, height: 350)
                        .clipped()
                        .environment(\.locale, Locale.init(identifier: "pt"))
                        .foregroundColor(LBColor.background)
                    LBButton(title: LBStrings.General.confirm) {
                        dismiss()
                    }
                    .padding(20)
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
