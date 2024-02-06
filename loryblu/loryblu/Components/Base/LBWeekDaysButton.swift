import SwiftUI

struct LBWeekDaysButton: View {
    @Binding var sunday: Bool
    @Binding var monday: Bool
    @Binding var tuesday: Bool
    @Binding var wednesday: Bool
    @Binding var thurday: Bool
    @Binding var friday: Bool
    @Binding var satuday: Bool
    var addFrequency: (Bool,LocbookTask.Frequency) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(LBColor.backgroundCards)
                .frame(height: 45)
            
            HStack(spacing: 20) {
                DaysButton(text: "D") {
                    sunday.toggle()
                    addFrequency(sunday,LocbookTask.Frequency.sun)
                }
                DaysButton(text: "S") {
                    monday.toggle()
                    addFrequency(monday,LocbookTask.Frequency.mon)
                }
                DaysButton(text: "T") {
                    tuesday.toggle()
                    addFrequency(tuesday,LocbookTask.Frequency.tue)
                }
                DaysButton(text: "Q") {
                    wednesday.toggle()
                    addFrequency(wednesday,LocbookTask.Frequency.wed)
                }
                DaysButton(text: "Q") {
                    thurday.toggle()
                    addFrequency(thurday,LocbookTask.Frequency.thu)
                }
                DaysButton(text: "S") {
                    friday.toggle()
                    addFrequency(friday,LocbookTask.Frequency.fri)
                }
                DaysButton(text: "S") {
                    satuday.toggle()
                    addFrequency(satuday,LocbookTask.Frequency.sat)
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
                .font(LBFont.head6)
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
                         satuday: .constant(true), addFrequency: {_,_ in})
    }
}
