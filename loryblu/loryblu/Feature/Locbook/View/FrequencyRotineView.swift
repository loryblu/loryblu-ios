import SwiftUI

enum Period: Equatable {
    case morning
    case afternoon
    case night
}

struct FrequencyRotineView: View {
        
    // MARK: - Defines
    
    struct Props {
        var task: LocbookTask
        let onSubmit: ClosureType.VoidVoid?
        var onClose : ClosureType.VoidVoid?
        
        var title: String {
            task.categoryTitle ?? ""
        }
    }

    // MARK: - Properties
    
    var props: Props
    var model = FrequencyRotineModel()
    @State var formConfig = FormConfig()
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
        
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
                             satuday: $formConfig.saturday)
            Spacer()

            LBButton(title: LBStrings.General.confirm) {
                formConfig
                props.onSubmit?()
            }
        }
        .locbookToolbar(title: props.title, onClose: { props.onClose?() })
        .padding(24)
    }

    var frequecyAction: some View {
        HStack(alignment: .center, spacing: 12) {
            Button(LBStrings.FrequencyRotine.morning) {
                formConfig.period = .morning
            }
            .buttonStyle(
                FrequencyButtonStyle(
                    style: .light,
                    image: LBIcon.sun.rawValue,
                    selected: formConfig.period == .morning
                )
            )

            Button(LBStrings.FrequencyRotine.afternoon) {
                formConfig.period = .afternoon
            }
            .buttonStyle(
                FrequencyButtonStyle(
                    style: .medium,
                    image: LBIcon.evining.rawValue,
                    selected: formConfig.period == .afternoon
                )
            )
            
            Button(LBStrings.FrequencyRotine.night) {
                formConfig.period = .night
            }
            .buttonStyle(
                FrequencyButtonStyle(
                    style: .dark,
                    image: LBIcon.moon.rawValue,
                    selected: formConfig.period == .night
                )
            )
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
        var saturday: Bool = false
        var morningSet: Bool = true
        var afternoonSet: Bool = false
        var nightSet: Bool = false
        var period: LocbookTask.Shift = .morning
        var task: LocbookTask = .init()

        func makeFrequency() -> [LocbookTask.Frequency] {
                    var result: [LocbookTask.Frequency] = []

                    if sunday { result.append(.sun) }
                    if monday { result.append(.mon) }
                    if tuesday { result.append(.tue) }
                    if wednesday { result.append(.wed) }
                    if thurday { result.append(.thu) }
                    if friday { result.append(.fri) }
                    if saturday { result.append(.sat) }

                    return result
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
    FrequencyRotineView(
        props: .init(task: LocbookTask(categoryTitle: "Title of the task"), onSubmit: nil)
    ).locbookToolbar(title: "Title of the task" , onClose: { })
}
