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
    @Binding var title: String

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack(spacing: 20) {
                Text("<")
                Text(title)
                    .font(LBFont.titleAction)
                    .foregroundStyle(LBColor.titlePrimary)
                Spacer()
                Image(LBIcon.close2.rawValue)
               }
            LBIcon.progression3.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,minHeight: 40)

            HStack {
                Text(LBStrings.FrequencyRotine.workPeriod)
                    .font(LBFont.buttonSmall)
                .foregroundStyle(LBColor.titlePrimary)
                Spacer()
            }

            frequecyAction

            VStack(spacing:8) {
                HStack {
                    Text(LBStrings.FrequencyRotine.frequencyRotine)
                        .font(LBFont.buttonSmall)
                        .foregroundStyle(LBColor.titlePrimary)
                    Spacer()
                }
                HStack {
                    Text(LBStrings.FrequencyRotine.frequencyDays)
                        .font(LBFont.caption1)
                    .foregroundStyle(LBColor.titlePrimary)
                    Spacer()
                }
            }

            LBWeekDaysButton(sunday: $sunday,
                             monday: $monday,
                             tuesday: $tuesday,
                             wednesday: $wednesday,
                             thurday: $thurday,
                             friday: $friday,
                             satuday: $satuday)
            Spacer()

            LBButton(title: LBStrings.General.confirm) {
                print("ok")
            }
        }
    }

    var frequecyAction: some View {
        HStack(alignment: .center, spacing: 12) {
            ImageLabel(image: LBIcon.sun.rawValue,
                       name: LBStrings.FrequencyRotine.morning,
                       backImage: morningSet ? LBColor.backgroundCards : LBColor.grayLight,
                       borderImage: morningSet ? LBColor.titlePrimary : LBColor.placeholder,
                       font: LBFont.titleAction)
            .onTapGesture {
                period = .mornig
                buttonSelect()
            }

            ImageLabel(image: LBIcon.evining.rawValue,
                       name: LBStrings.FrequencyRotine.afternoon,
                       backImage: afternoonSet ? LBColor.backgroundCards : LBColor.grayLight,
                       borderImage: afternoonSet ? LBColor.titlePrimary : LBColor.placeholder,
                       font: LBFont.titleAction)
             .onTapGesture {
                period = .afternoon
                buttonSelect()
            }

            ImageLabel(image: LBIcon.moon.rawValue,
                       name: LBStrings.FrequencyRotine.night,
                       backImage: nightSet ? LBColor.backgroundCards : LBColor.grayLight,
                       borderImage: nightSet ? LBColor.titlePrimary : LBColor.placeholder,
                       font: LBFont.titleAction)
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
                    satuday: true, title: .constant(LBStrings.Locbook.titleStudy
))
}
