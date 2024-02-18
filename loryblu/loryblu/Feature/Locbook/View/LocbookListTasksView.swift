import SwiftUI

struct LocbookListTasksView: View {
    @State private var securityIsOn = true

    // TODO: Implementar funcionalidade e filtro
    let shiftsEXEMPLO = [
        ShiftItem(name: LBStrings.FrequencyRotine.morning, icon: LBIcon.sunSmall.rawValue,backgroundColor: LBColor.buttonBackgroundLight, letterColor: .black,isSelected: false),
        ShiftItem(name: LBStrings.FrequencyRotine.afternoon, icon: LBIcon.eviningSmall.rawValue, backgroundColor: LBColor.buttonBackgroundMedium,letterColor: .white, isSelected: true),
        ShiftItem(name: LBStrings.FrequencyRotine.night, icon: LBIcon.moonSmall.rawValue,backgroundColor: LBColor.buttonBackgroundDark, letterColor: .white,isSelected: false)]

    // TODO: Implementar chamada da model e filtro
    let listTasksModelEXEMPLO: [CardTaskRegistered] = [
        CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: <#T##Binding<Bool>#>),
        CardTaskRegistered(nameAction: LBStrings.Locbook.titleStudy, imageTask: LBIcon.school.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundMedium, isSecurity: .constant(false)),
        CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonGenderEnable, isSecurity: .constant(true)),
        CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: .constant(true))
    ]

    // TODO: Implementar navegação
    struct Props {
        var onClose: ClosureType.VoidVoid?
    }

    var props: Props

    var body: some View {
        VStack() {
            VStack(spacing: 16) {
                LBWeekDaysButton(  // TODO: implementar funcionalidade e filtro
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
            .padding(.init(top: 16, leading: 24, bottom: 0, trailing: 24))

            listTasks

        }
        .locbookToolbar(title: LBStrings.Locbook.title, onClose: { props.onClose?() })
        .backgroundStyle(LBColor.background)

    }

    var listTasks: some View {
        List() {
            HStack(alignment: .center){
                Spacer()
                Toggle(isOn: $securityIsOn) {
                    Image(systemName: securityIsOn ? "lock" : "lock.open")
                }
                .frame(width: 52, height: 32)
                .toggleStyle(
                    SwitchToggleStyle(
                        tint: securityIsOn ? LBColor.buttonBackgroundDark : LBColor.placeholder)
                )
            }

            ForEach(0..<listTasksModelEXEMPLO.count) { index in
                listTasksModelEXEMPLO[index]
            }
            .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
    }
}

extension LocbookListTasksView.Props: Hashable {
    static func == (lhs: LocbookListTasksView.Props, rhs: LocbookListTasksView.Props) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    LocbookListTasksView(props: .init(onClose: {}))
}
