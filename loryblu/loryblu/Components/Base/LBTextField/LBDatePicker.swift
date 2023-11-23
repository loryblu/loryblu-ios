import SwiftUI

struct LBDatePicker: View {
    let onConfirm: (Date) -> Void
    let onCancel: () -> Void
    @State var selectedDate = Date()
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -10, to: Date()) ?? Date.now
        let max = Calendar.current.date(byAdding: .year, value: 0, to: Date()) ?? Date.now
        return min...max
    }
    var body: some View {

        ZStack(alignment: .center ) {
            Color.gray.opacity(0.2)
                 .ignoresSafeArea()
                 .overlay {
                     VStack {
                         DatePicker(LBStrings.Register.birthDay, selection: $selectedDate,
                                    in: dateClosedRange, displayedComponents: .date)
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
                         }.padding(.vertical,-35)
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
