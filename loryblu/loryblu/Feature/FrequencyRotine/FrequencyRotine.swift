import SwiftUI
enum Period: Equatable {
    case mornig
    case afternoon
    case night
}

struct FrequencyRotine: View {
    @State var sunday: Bool
    @State var monday: Bool
    @State var tuesday: Bool
    @State var wednesday: Bool
    @State var thurday: Bool
    @State var friday: Bool
    @State var satuday: Bool
    @State var morningSet: Bool = true
    @State var afternoonSet: Bool = false
    @State var nightSet: Bool = false
    var body: some View {

        VStack(alignment: .center, spacing: 15) {

            Text(LBStrings.FrequencyRotine.title)
                .font(LBFont.titleAction)
                .foregroundStyle(LBColor.borderSelectLogbook)
                .padding(30)

            Text(LBStrings.FrequencyRotine.frequncySubtitle)
                .font(LBFont.buttonSmall)
                .foregroundStyle(LBColor.borderSelectLogbook)
                .padding(.init(top: 56, leading: 0, bottom: 0, trailing: 0))

            frequecyAction

            LBWeekDaysButton(sunday: $sunday,
                             monday: $monday,
                             tuesday: $tuesday,
                             wednesday: $wednesday,
                             thurday: $thurday,
                             friday: $friday,
                             satuday: $satuday)
            .padding()
            Spacer()

            LBButton(title: LBStrings.General.confirm) {
                print("ok")
            }
            .padding(80)
        }
    }

    var frequecyAction: some View {
        HStack(alignment: .center, spacing: 12) {
            ImageLabel(image: LBIcon.sun.rawValue,
                       name: LBStrings.FrequencyRotine.morning,
                       backImage: LBColor.backgroundCards,
                       borderImage: LBColor.borderImageLogbook,
                       font: LBFont.titleAction)
            .frame(width: 102)

            ImageLabel(image: LBIcon.evining.rawValue,
                       name: LBStrings.FrequencyRotine.afternoon,
                       backImage: LBColor.backgroundCards,
                       borderImage: LBColor.borderImageLogbook,
                       font: LBFont.titleAction)
            .frame(width: 102)

            ImageLabel(image: LBIcon.moon.rawValue,
                       name: LBStrings.FrequencyRotine.morning,
                       backImage: LBColor.backgroundCards,
                       borderImage: LBColor.borderImageLogbook,
                       font: LBFont.titleAction)
            .frame(width: 102)

        }
        .frame(height: 110)
    }

    func buttonSelect() {

    }
}

#Preview {
    FrequencyRotine(sunday: true,
                    monday: false,
                    tuesday: true,
                    wednesday: false,
                    thurday: true,
                    friday: false,
                    satuday: true)
}
