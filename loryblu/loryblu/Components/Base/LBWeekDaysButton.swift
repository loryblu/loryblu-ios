import SwiftUI

struct LBWeekDaysButton: View {
    @Binding var sunday: Bool
    @Binding var monday: Bool
    @Binding var tuesday: Bool
    @Binding var wednesday: Bool
    @Binding var thurday: Bool
    @Binding var friday: Bool
    @Binding var satuday: Bool
    var isClickable: Bool = true
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(LBColor.backgroundCards)
                .frame(height: 45)
                HStack(spacing: 20) {
                    
                DaysButton(isSet: sunday,text: "D", isClickable: isClickable) {
                    sunday.toggle()
                }
                DaysButton(isSet: monday,text: "S", isClickable: isClickable) {
                    monday.toggle()
                }
                DaysButton(isSet: tuesday,text: "T", isClickable: isClickable) {
                    tuesday.toggle()
                }
                DaysButton(isSet: wednesday,text: "Q", isClickable: isClickable) {
                    wednesday.toggle()
                }
                DaysButton(isSet: thurday, text: "Q", isClickable: isClickable) {
                    thurday.toggle()
                }
                DaysButton(isSet: friday, text: "S", isClickable: isClickable) {
                    friday.toggle()
                }
                DaysButton(isSet: satuday, text: "S", isClickable: isClickable) {
                    satuday.toggle()
                }
            }
        }
    }
}

struct DaysButton: View {
    @State var isSet: Bool
    @State var text: String
    var isClickable: Bool
    var action: () -> Void
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(isSet ? LBColor.buttonGenderEnable : LBColor.backgroundCards)
                .onTapGesture {
                    if isClickable {
                        isSet.toggle()
                        action()
                    }
                }
                Text(text)
                .font(LBFont.titleTask)
                .foregroundColor(isSet ? LBColor.backgroundCards : LBColor.buttonGenderEnable)
        }

    }
}

struct LBWeekDaysButton_Previews: PreviewProvider {
    static var previews: some View {
        LBWeekDaysButton(sunday: .constant(true),
                         monday: .constant(true),
                         tuesday: .constant(true),
                         wednesday: .constant(true),
                         thurday: .constant(true),
                         friday: .constant(true),
                         satuday: .constant(true))
    }
}
