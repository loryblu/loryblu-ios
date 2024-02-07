import SwiftUI

enum Period: Equatable {
    case morning
    case afternoon
    case night
}

struct FrequencyRotineView: View {
    
    init(props: Props, formConfig: FormConfig = FormConfig()) {
        var config = formConfig
        config.task = props.task
        self.props = props
        self._formConfig = State(initialValue: config)
    }
        
    // MARK: - Defines
    
    struct Props {
        var task: LocbookTask
        let onNext: ClosureType.LocbookTaskVoid?
        var onClose : ClosureType.VoidVoid?
        
        var title: String {
            task.categoryTitle ?? ""
        }
    }

    // MARK: - Properties
    
    let props: Props
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
                             satuday: $formConfig.satuday, addFrequency: { isNotSelected, frequency in
                if isNotSelected {
                    formConfig.frequency.append(frequency)
                } else {
                    formConfig.frequency.removeAll { i in frequency == i }
                }
            })
            Spacer()

            LBButton(title: LBStrings.General.confirm) {
                
                formConfig.task.frequency = formConfig.frequency
                
                if formConfig.task.shift == nil {
                    formConfig.task.shift = .morning
                }
                
                if !formConfig.frequency.isEmpty {
                    props.onNext?(formConfig.task)
                }
            }
        }
        .locbookToolbar(title: props.title, onClose: { props.onClose?() })
        .padding(24)
    }

    var frequecyAction: some View {
        HStack(alignment: .center, spacing: 12) {
            Button(LBStrings.FrequencyRotine.morning) {
                formConfig.period = .morning
                formConfig.task.shift = .morning
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
                formConfig.task.shift = .afternoon
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
                formConfig.task.shift = .night
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
        var satuday: Bool = false
        var morningSet: Bool = true
        var afternoonSet: Bool = false
        var nightSet: Bool = false
        var period: Period = .morning
        var frequency:[LocbookTask.Frequency] = []
        var task: LocbookTask = .init()
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
        props: .init(task: LocbookTask(categoryTitle: "Title of the task"), onNext: nil)
    ).locbookToolbar(title: "Title of the task" , onClose: { })
}
