import SwiftUI
struct LBWeekDaysButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(LBColor.backgroundCards)
                .frame(height: 45)
            
            HStack(spacing: 20) {
                DaysButton(text: "D") {
                    print("OK")
                }
                DaysButton(text: "S") {

                }
                DaysButton(text: "T") {

                }
                DaysButton(text: "Q") {

                }
                DaysButton(text: "Q") {

                }
                DaysButton(text: "S") {

                }
                DaysButton(text: "S") {

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

#Preview {
    LBWeekDaysButton()
}
