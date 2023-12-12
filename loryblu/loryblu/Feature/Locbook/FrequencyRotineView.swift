import SwiftUI

enum Period: Equatable {
    case morning
    case afternoon
    case night
}

struct FrequencyRotineView: View {
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
    @State var period: Period = .morning
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
                    .resizable()
                    .frame(width: 18, height: 18)
               }
            LBIcon.progression3.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,minHeight: 40)
                .padding(.bottom,39)

            HStack {
                Text(LBStrings.FrequencyRotine.workPeriod)
                    .font(LBFont.buttonSmall)
                .foregroundStyle(LBColor.titlePrimary)
                Spacer()
            }

            frequecyAction
                .padding(.bottom,36)

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
            }.padding(.bottom,10)

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
        }.padding(24)
    }

    var frequecyAction: some View {
        HStack(alignment: .center, spacing: 12) {
            ImageLabel(image: LBIcon.sun.rawValue,
                       name: LBStrings.FrequencyRotine.morning,
                       font: LBFont.titleTask, segment: .default)
            .background(morningSet ? LBColor.backgroundCards : LBColor.grayLight)
            .cornerRadius(12.0)
            .onTapGesture {
                period = .morning

                buttonSelect()
            }


            ImageLabel(image: LBIcon.evining.rawValue,
                       name: LBStrings.FrequencyRotine.afternoon,
                       font: LBFont.titleTask, segment: .default)
            .background(afternoonSet ? LBColor.backgroundAfternoon : LBColor.grayLight)
            .cornerRadius(12)
            .onTapGesture {
                period = .afternoon
                buttonSelect()
            }

            ImageLabel(image: LBIcon.moon.rawValue,
                       name: LBStrings.FrequencyRotine.night,
                       font: LBFont.titleTask, segment: .default)
            .background(nightSet ? LBColor.text : LBColor.grayLight)
            .cornerRadius(12)
            .onTapGesture {
                period = .night
                buttonSelect()
            }

        }
        .frame(height: 112)
    }

    func buttonSelect() {
        if period == .morning {
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
    FrequencyRotineView(sunday: true,
                    monday: false,
                    tuesday: true,
                    wednesday: false,
                    thurday: true,
                    friday: false,
                    satuday: true, title: .constant(LBStrings.Locbook.titleStudy
))
}
