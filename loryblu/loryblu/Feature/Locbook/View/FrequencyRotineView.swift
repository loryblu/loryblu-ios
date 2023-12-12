import SwiftUI

enum Period: Equatable {
    case morning
    case afternoon
    case night
}

struct FrequencyRotineView: View {
    
    // MARK: - Defines
    
    struct Props {
        var title: String
        let onSubmit: ClosureType.VoidVoid?
    }

    // MARK: - Properties
    
    let props: Props
    @State var formConfig = FormConfig()
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack(spacing: 20) {
                Text("<")

                Text(props.title)
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

            LBWeekDaysButton(sunday: $formConfig.sunday,
                             monday: $formConfig.monday,
                             tuesday: $formConfig.tuesday,
                             wednesday: $formConfig.wednesday,
                             thurday: $formConfig.thurday,
                             friday: $formConfig.friday,
                             satuday: $formConfig.satuday)
            Spacer()

            LBButton(title: LBStrings.General.confirm) {
                props.onSubmit?()
            }
        }.padding(24)
    }

    var frequecyAction: some View {
        HStack(alignment: .center, spacing: 12) {
            ImageLabel(image: LBIcon.sun.rawValue,
                       name: LBStrings.FrequencyRotine.morning,
                       font: LBFont.titleTask, segment: .default)
            .background(formConfig.morningSetColor)
            .cornerRadius(12.0)
            .onTapGesture {
                formConfig.period = .morning
                formConfig.buttonSelect()
            }


            ImageLabel(image: LBIcon.evining.rawValue,
                       name: LBStrings.FrequencyRotine.afternoon,
                       font: LBFont.titleTask, segment: .default)
            .background(formConfig.afternoonSetColor)
            .cornerRadius(12)
            .onTapGesture {
                formConfig.period = .afternoon
                formConfig.buttonSelect()
            }

            ImageLabel(image: LBIcon.moon.rawValue,
                       name: LBStrings.FrequencyRotine.night,
                       font: LBFont.titleTask, segment: .default)
            .background(formConfig.nightSetColor)
            .cornerRadius(12)
            .onTapGesture {
                formConfig.period = .night
                formConfig.buttonSelect()
            }
        }
        .frame(height: 112)
    }
}


extension FrequencyRotineView {
    struct FormConfig {
        var sunday: Bool = false
        var monday: Bool = false
        var tuesday: Bool = false
        var wednesday: Bool = false
        var thurday: Bool = false
        var friday: Bool = false
        var satuday: Bool = false
        var morningSet: Bool = true
        var afternoonSet: Bool = false
        var nightSet: Bool = false
        var period: Period = .morning
        
        var morningSetColor: Color {
            morningSet ? LBColor.backgroundCards : LBColor.grayLight
        }
        
        var afternoonSetColor: Color {
            afternoonSet ? LBColor.backgroundAfternoon : LBColor.grayLight
        }
        
        var nightSetColor: Color {
            nightSet ? LBColor.text : LBColor.grayLight
        }
        
        mutating func buttonSelect() {
            morningSet = false
            afternoonSet = false
            nightSet = false
            
            switch period {
            case .morning:
                morningSet = true

            case .afternoon:
                afternoonSet = true

            case .night:
                nightSet = true
            }
        }
    }
}

extension FrequencyRotineView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    FrequencyRotineView(props: .init(title: "Title", onSubmit: nil))
}
