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
    @State var period: Period = .mornig
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {

            Text(LBStrings.FrequencyRotine.title)
                .font(LBFont.titleAction)
                .foregroundStyle(LBColor.titlePrimary)
                .padding(30)

            Text(LBStrings.FrequencyRotine.frequncySubtitle)
                .font(LBFont.buttonSmall)
                .foregroundStyle(LBColor.titlePrimary)
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
                       backImage: morningSet ? LBColor.backgroundCards : LBColor.grayLight,
                       borderImage: morningSet ? LBColor.titlePrimary : LBColor.placeholder,
                       font: LBFont.titleAction)
            .frame(width: 102)
            .onTapGesture {
                period = .mornig
                buttonSelect()
            }

            ImageLabel(image: LBIcon.evining.rawValue,
                       name: LBStrings.FrequencyRotine.afternoon,
                       backImage: afternoonSet ? LBColor.backgroundCards : LBColor.grayLight,
                       borderImage: afternoonSet ? LBColor.titlePrimary : LBColor.placeholder,
                       font: LBFont.titleAction)
            .frame(width: 102)
            .onTapGesture {
                period = .afternoon
                buttonSelect()
            }

            ImageLabel(image: LBIcon.moon.rawValue,
                       name: LBStrings.FrequencyRotine.night,
                       backImage: nightSet ? LBColor.backgroundCards : LBColor.grayLight,
                       borderImage: nightSet ? LBColor.titlePrimary : LBColor.placeholder,
                       font: LBFont.titleAction)
            .frame(width: 102)
            .onTapGesture {
                period = .night
                buttonSelect()
            }

        }
        .frame(height: 110)
    }

    func buttonSelect() {
        if period == .mornig {
            morningSet = true
            afternoonSet = false
            nightSet = false
        }
        if period == .afternoon {
            morningSet = false
            afternoonSet = true
            nightSet = false
        }
        if period == .night {
            morningSet = false
            afternoonSet = false
            nightSet = true
        }
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
