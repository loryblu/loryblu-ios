import SwiftUI

struct LBDatePicker: View {
    let onConfirm: (Date) -> Void
    let onCancel: () -> Void
    @State var selectedDate = Date()
    var body: some View {

        ZStack(alignment: .center ) {
            Color.gray.opacity(0.2)
                 .ignoresSafeArea()
                 .overlay {
                     VStack {
                         DatePicker(LBStrings.Register.birthDay, selection: $selectedDate, displayedComponents: .date)
                             .datePickerStyle(.graphical)
                             .padding()
                             .background(Color.white.cornerRadius(20))
                             .clipped()
                             .environment(\.locale, Locale.init(identifier: "pt"))
                             .foregroundColor(LBColor.background)
                         HStack {
                             Button(LBStrings.General.confirm) {
                                 onConfirm(selectedDate)
                             }
                             Button(LBStrings.General.cancel) {
                                 onCancel()
                             }
                         }.padding(.vertical,-30)
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
