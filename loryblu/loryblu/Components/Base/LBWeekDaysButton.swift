import SwiftUI

struct LBWeekDaysButton: View {
    @Binding var sunday: Bool
    @Binding var monday: Bool
    @Binding var tuesday: Bool
    @Binding var wednesday: Bool
    @Binding var thurday: Bool
    @Binding var friday: Bool
    @Binding var satuday: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(LBColor.backgroundCards)
                .frame(height: 45)
            
            HStack(spacing: 20) {
                DaysButton(text: "D") {
                    sunday.toggle()
                }
                DaysButton(text: "S") {
                    monday.toggle()
                }
                DaysButton(text: "T") {
                    tuesday.toggle()
                }
                DaysButton(text: "Q") {
                    wednesday.toggle()
                }
                DaysButton(text: "Q") {
                    thurday.toggle()
                }
                DaysButton(text: "S") {
                    friday.toggle()
                }
                DaysButton(text: "S") {
                    satuday.toggle()
                }

            }
        }
    }
}

struct DaysButton: View {
    @State var isSet: Bool = false
    @State var text: String
    var action: () -> Void
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(isSet ? LBColor.buttonGenderEnable : LBColor.backgroundCards)
                .onTapGesture {
                    isSet.toggle()
                    action()
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
