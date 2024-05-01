import SwiftUI

struct ShiftItem {
    var name: String
    var icon: String
    var backgroundColor: Color
    var letterColor: Color
    var isSelected: Bool
}

struct LBShiftItemsComponent: View {
    @State var isPressed: Bool = false
    let shifts: [ShiftItem]
    var isClickable: Bool = true
    var onClick: (String) -> Void = { _ in }
    var body: some View {
        HStack {
            ForEach(shifts, id: \.name) { shift in
                if shift.isSelected {
                    LBSelectedItemShift(
                        shiftName: shift.name,
                        iconValue: shift.icon,
                        backgroundColor: shift.backgroundColor,
                        letterColor: shift.letterColor).scaleEffect(isPressed ? 1.50 : 1.0)
                } else {
                    Text(shift.name)
                        .font(LBFont.bodyLarge)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onTapGesture {
                            if isClickable {
                                onClick(shift.name)
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isPressed = true
                                }
                                Task {
                                    try? await Task.sleep(nanoseconds: 7_500_000_000)
                                }
                                withAnimation {
                                    isPressed = false
                                }
                            }
                        }
                }
            }
        }
        .background(LBColor.textfield)
        .cornerRadius(8)
        .frame(maxWidth:.infinity,alignment: .center)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LBShiftItemsComponent(shifts: [
        ShiftItem(name: LBStrings.FrequencyRotine.morning, icon: LBIcon.sunSmall.rawValue,backgroundColor: LBColor.buttonBackgroundLight, letterColor: .black,isSelected: true),
        ShiftItem(name: LBStrings.FrequencyRotine.afternoon, icon: LBIcon.eviningSmall.rawValue, backgroundColor: LBColor.buttonBackgroundMedium,letterColor: .white, isSelected: false),
        ShiftItem(name: LBStrings.FrequencyRotine.night, icon: LBIcon.moonSmall.rawValue,backgroundColor: LBColor.buttonBackgroundDark, letterColor: .white,isSelected: false)])
}
