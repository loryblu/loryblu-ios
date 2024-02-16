import SwiftUI

struct LocbookListTasks: View {
    @State private var securityIsOn = true

    let shiftsEXEMPLO = [
        ShiftItem(name: LBStrings.FrequencyRotine.morning, icon: LBIcon.sunSmall.rawValue,backgroundColor: LBColor.buttonBackgroundLight, letterColor: .black,isSelected: false),
        ShiftItem(name: LBStrings.FrequencyRotine.afternoon, icon: LBIcon.eviningSmall.rawValue, backgroundColor: LBColor.buttonBackgroundMedium,letterColor: .white, isSelected: true),
        ShiftItem(name: LBStrings.FrequencyRotine.night, icon: LBIcon.moonSmall.rawValue,backgroundColor: LBColor.buttonBackgroundDark, letterColor: .white,isSelected: false)]

//    let listTasksModel: [CardTasksModel]

    var body: some View {
        VStack() {
            VStack(spacing: 16) {
                LBWeekDaysButton(
                    sunday: .constant(false),
                    monday: .constant(true),
                    tuesday: .constant(false),
                    wednesday: .constant(false),
                    thurday: .constant(true),
                    friday: .constant(false),
                    satuday: .constant(false)
                )

                LBShiftItemsComponent(shifts: shiftsEXEMPLO)
            }
            .padding(.init(top: 16, leading: 24, bottom: 16, trailing: 24))

            HStack(alignment: .center){
                Spacer()
                Toggle(isOn: $securityIsOn) {

                }
                .frame(width: 52, height: 32)
                .toggleStyle(SwitchToggleStyle(tint: LBColor.buttonBackgroundDark))
            }
            .padding(.trailing, 30)

            listTasks

        }
    }

    var listTasks: some View {
        List() {
            CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: .constant(true))

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleStudy, imageTask: LBIcon.school.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundMedium, isSecurity: .constant(false))

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonGenderEnable, isSecurity: .constant(true))

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: .constant(true))

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleStudy, imageTask: LBIcon.school.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundMedium, isSecurity: .constant(false))

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonGenderEnable, isSecurity: .constant(true))
            
            CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: .constant(true))

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleStudy, imageTask: LBIcon.school.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundMedium, isSecurity: .constant(false))

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonGenderEnable, isSecurity: .constant(true))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LocbookListTasks()
}
