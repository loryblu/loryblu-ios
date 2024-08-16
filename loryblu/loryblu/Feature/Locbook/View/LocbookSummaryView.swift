import SwiftUI

struct DayOfWeekOption {
    var name: String
    var isSelected: Bool
    var frequency: LocbookTask.Frequency
}

struct LocbookSummaryView: View {

    // MARK: - Defines
    struct Props {
        var task: LocbookTask
        var title: String
        let onSubmitNewTask: ClosureType.VoidVoid?
        let onSubmitEditedTask: ClosureType.VoidVoid?
        let onEditTaskPath: ClosureType.EditTaskPath?
        var onClose: ClosureType.VoidVoid?
        let addOrEdit: AddOrEditType
        var taskSelected: TaskSelected?

        var frequencyDaysOfWeek: [DayOfWeekOption] {
            getDaysOfWeekOptionsUiModel(frequency: task.frequency)
        }

        var taskImage: String {
            let imageLabel = getImageLabelByCategoryId(categoryId: task.categoryId!)
            return imageLabel.image
        }
        var taskName: String {
            return getImageLabelByCategoryId(categoryId: task.categoryId!).name
        }
    }

    // MARK: - Properties
    let props: Props
    @StateObject var model = SummaryViewModel()
    @State var formConfig: FormConfig

    init(props: Props, formConfig: FormConfig? = nil) {
        self.props = props
        var formConfig = FormConfig(task: props.task)
        formConfig.initProperties(frequency: props.task.frequency)
        self._formConfig  = State(initialValue: formConfig)
    }

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: props.addOrEdit == .add ? 15 : 32) {
                summaryProgressBar
                summaryTaskImage
                summaryTaskProps
                summaryShiftContent
                summaryFrequencyContent
                summaryButtonConfirmation
            }
            .locbookToolbar(
                title: props.title,
                addOrEdit: props.addOrEdit,
                onClose: { props.onClose?() }

            ).onAppear {
                model.iniShifts(shift: props.task.shift)
            }
            .padding(24)

            if model.stateTask == .loading {
                LoadingView()
            }
        }
    }

    var summaryProgressBar: some View {
        let isVisible = props.addOrEdit == .add
        return Group {
            if isVisible {
                LBIcon.progression4.image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, minHeight: 40)
            }
        }
    }

    var summaryTaskImage: some View {
        Image(props.taskImage)
            .resizable()
            .scaledToFit()
            .scenePadding()
            .overlay {
                RoundedRectangle(cornerRadius: 6.0)
                    .stroke(
                        LBColor.backgroundCardsLabel,
                        lineWidth: 4.0
                    )
            }
            .background(LBColor.backgroundCards)
            .cornerRadius(6.0)
            .frame(maxWidth: 200, maxHeight: 200, alignment: .center)
    }

    var summaryTaskProps: some View {
        VStack(spacing: 8) {
            categoryContent
            nameContent
        }
    }

    var categoryContent: some View {
        HStack(alignment: .center, spacing: 5) {
            Text(LBStrings.SummaryLocbook.category)
                .font(LBFont.head5)
                .foregroundStyle(LBColor.text)
                .frame(alignment: .topLeading)
            Spacer()

            LBCategoryButton(
                title: props.task.categoryTitle,
                isClickable: props.addOrEdit == .add ? false : true,
                onClick: { props.onEditTaskPath?(EditPath.category) }
            )

        }.frame(maxWidth: .infinity)
    }

    var nameContent: some View {
        HStack(alignment: .center, spacing: 24) {
            Text(LBStrings.SummaryLocbook.task)
                .font(LBFont.head5)
                .foregroundStyle(LBColor.text)
                .frame(alignment: .topLeading)
            Spacer()

            LBCategoryButton(
                title: props.task.taskTitle ?? props.taskName,
                isClickable: props.addOrEdit == .add ? false : true,
                onClick: { props.onEditTaskPath?(EditPath.task) }
            )
        }.frame(maxWidth: .infinity)
    }

    var summaryShiftContent: some View {
        VStack {
            Divider()
            Text(LBStrings.SummaryLocbook.shift)
                .font(LBFont.head5)
                .foregroundStyle(LBColor.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            LBShiftItemsComponent(
                shifts: model.shifts,
                isClickable: props.addOrEdit == .edit,
                onClick: { shiftSelected in
                    model.onChangeShift(
                        shiftSelected: shiftSelected,
                        changeTaskShift: { shift in
                            formConfig.task?.shift = shift
                        }
                    )
                }
            )
        }
    }

    var summaryFrequencyContent: some View {
        VStack {
            Text(LBStrings.SummaryLocbook.frequency)
                .font(LBFont.head5)
                .foregroundStyle(LBColor.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(LBStrings.SummaryLocbook.frequencyDescription)
                .font(LBFont.bodyMedium)
                .foregroundStyle(LBColor.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            LBWeekDaysButton(
                sunday: $formConfig.sunday,
                monday: $formConfig.monday,
                tuesday: $formConfig.tuesday,
                wednesday: $formConfig.wednesday,
                thurday: $formConfig.thurday,
                friday: $formConfig.friday,
                satuday: $formConfig.saturday,
                isClickable: props.addOrEdit == .edit
            )
        }
    }

    var summaryButtonConfirmation: some View {
        let editFlow = props.addOrEdit == AddOrEditType.edit
        return Group {
            if editFlow {
                editConfirmationContent
            } else {
                addConfirmationContent
            }
        }
    }

    var addConfirmationContent: some View {
        LBButton(title: LBStrings.SummaryLocbook.submitTask) {
            Task {
                await  model.saveTask(task: props.task)
                if model.stateTask == .success {
                    props.onSubmitNewTask?()
                }
            }
        }
    }

    var editConfirmationContent: some View {
        HStack {
            LBButton(title: "Cancelar", style: .primaryOff) {
                props.onClose?()
            }
            LBButton(title: "Salvar") {
                formConfig.task?.frequency = formConfig.makeFrequency()

                guard let editedTask = formConfig.task else {
                    return
                }
                
                props.taskSelected?.setupTaskSelected(task: editedTask)

                Task {
                    await model.saveEditedTask(
                        task: editedTask,
                        onDismiss: {
                            props.onSubmitEditedTask?()
                        })
                }
            }
        }
    }
}

extension LocbookSummaryView {
    private func showCloseBtnOrNot(addOrEdit: AddOrEditType) -> Bool {
        if addOrEdit == .edit {
            return false
        } else {
            return true
        }
    }

    struct FormConfig {
        var sunday: Bool = false
        var monday: Bool = false
        var tuesday: Bool = false
        var wednesday: Bool = false
        var thurday: Bool = false
        var friday: Bool = false
        var saturday: Bool = false
        var frequency: [LocbookTask.Frequency]?
        var task: LocbookTask?

        mutating func initProperties(frequency: [LocbookTask.Frequency]?) {
            if frequency != nil {
                frequency?.forEach { day in
                    switch day {
                    case .sun: self.sunday = true
                    case .mon: self.monday = true
                    case .tue: self.tuesday = true
                    case .wed: self.wednesday = true
                    case .thu: self.thurday = true
                    case .fri: self.friday = true
                    case .sat: self.saturday = true
                    }
                }
            }
        }

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

// swiftlint:disable switch_case_alignment
extension LocbookSummaryView.Props {
    func getShiftsUiModel(shift: LocbookTask.Shift?) -> [ShiftItem] {
        let shiftName = switch shift {
        case .morning:
            LBStrings.FrequencyRotine.morning
        case .afternoon:
            LBStrings.FrequencyRotine.afternoon
        default:
            LBStrings.FrequencyRotine.night
        }
// swiftlint:enable switch_case_alignment

        var shifts = [
            ShiftItem(
                name: LBStrings.FrequencyRotine.morning,
                icon: LBIcon.sunSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundLight,
                letterColor: .black,
                isSelected: false
            ),
            ShiftItem(
                name: LBStrings.FrequencyRotine.afternoon,
                icon: LBIcon.eviningSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundMedium,
                letterColor: .white,
                isSelected: false
            ),
            ShiftItem(
                name: LBStrings.FrequencyRotine.night,
                icon: LBIcon.moonSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundDark,
                letterColor: .white,
                isSelected: false
            )
        ]

        shifts = shifts.map { (shift: ShiftItem) -> ShiftItem in
            var mutableShift = shift
            if shift.name == shiftName {
                mutableShift.isSelected = true
            }
            return mutableShift
        }

        return shifts
    }

    func getDaysOfWeekOptionsUiModel(frequency: [LocbookTask.Frequency]?) -> [DayOfWeekOption] {

        var dayOfWeekOptions = [
            DayOfWeekOption(name: "D", isSelected: false, frequency: .sun),
            DayOfWeekOption(name: "S", isSelected: false, frequency: .mon),
            DayOfWeekOption(name: "T", isSelected: false, frequency: .tue),
            DayOfWeekOption(name: "Q", isSelected: false, frequency: .wed),
            DayOfWeekOption(name: "Q", isSelected: false, frequency: .thu),
            DayOfWeekOption(name: "S", isSelected: false, frequency: .fri),
            DayOfWeekOption(name: "S", isSelected: false, frequency: .sat)
        ]

        frequency?.forEach { frequency in
            dayOfWeekOptions = dayOfWeekOptions.map { (dayOfWeek: DayOfWeekOption) -> DayOfWeekOption in
                var mutableDayOfWeek = dayOfWeek
                if dayOfWeek.frequency == frequency {
                    mutableDayOfWeek.isSelected = true
                }
                return mutableDayOfWeek
            }
        }

        return dayOfWeekOptions
    }

    func getImageLabelByCategoryId(categoryId: String) -> ImageLabel {
        let list: [ImageLabel] = ListTasks.rotine + ListTasks.study
        let index = list.firstIndex { item in
            item.categoryID == categoryId
        }!
        return list[index]
    }
}

extension LocbookSummaryView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    LocbookSummaryView(
        props:
            .init(
                task: LocbookTask(
                    shift: .morning,
                    frequency: [LocbookTask.Frequency.mon],
                    categoryId: LBStrings.CategoryID.tvgame,
                    categoryTitle: LBStrings.Locbook.titleStudy
                ), title: "LocbookSumary",
                onSubmitNewTask: {},
                onSubmitEditedTask: { },
                onEditTaskPath: {_ in},
                addOrEdit: AddOrEditType.edit
            )
    )
}
