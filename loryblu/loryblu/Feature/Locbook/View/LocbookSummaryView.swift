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
        let onSubmit: ClosureType.VoidVoid?
        let onEditTaskPath: ClosureType.EditTaskPath?
        var onClose: ClosureType.VoidVoid?
        let addOrEdit: AddOrEditType

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
        print(props.task)
        self._formConfig  = State(initialValue: FormConfig(task: props.task))
    }

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            LBIcon.progression4.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, minHeight: 40)

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
            VStack(spacing: 8) {
                HStack(alignment: .center, spacing: 5) {
                    Text(LBStrings.SummaryLocbook.category)
                        .font(LBFont.head5)
                        .foregroundStyle(LBColor.text).frame(alignment: .topLeading)
                    Spacer()

                    LBCategoryButton(
                        title: props.task.categoryTitle,
                        isClickable: props.addOrEdit == .add ? false : true,
                        onClick: { props.onEditTaskPath?(EditPath.category) }
                    )

                }.frame(maxWidth: .infinity)

                HStack(alignment: .center, spacing: 24) {
                    Text(LBStrings.SummaryLocbook.task)
                        .font(LBFont.head5)
                        .foregroundStyle(LBColor.text)
                        .frame(alignment: .topLeading)
                    Spacer()

                    ZStack {
                        Text(props.task.taskTitle ?? props.taskName)
                            .padding(6)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .padding(6)
                            .font(LBFont.subtitle)
                    }
                    .background(LBColor.buttonBackgroundDark)
                    .cornerRadius(6)
                    .frame(maxWidth: .infinity)
                    .foregroundColor( .white)

                }.frame(maxWidth: .infinity)
            }

            Divider()

            Text(LBStrings.SummaryLocbook.shift)
                .font(LBFont.head5)
                .foregroundStyle(LBColor.text)
                .frame(maxWidth: .infinity, alignment: .leading)

            LBShiftItemsComponent(
                shifts: model.shifts,
                onClick: { shiftSelected in 
                    model.onChangeShift(
                        shiftSelected: shiftSelected,
                        changeTaskShift: { shift in
                            formConfig.task?.shift = shift
                        }
                    )
                }
            )

            VStack {
                Text(LBStrings.SummaryLocbook.frequency)
                    .font(LBFont.head5)
                    .foregroundStyle(LBColor.text)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(LBStrings.SummaryLocbook.frequencyDescription)
                    .font(LBFont.bodyMedium)
                    .foregroundStyle(LBColor.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LBColor.backgroundCards)
                    .frame(height: 45)

                HStack(spacing: 20) {
                    ForEach(props.frequencyDaysOfWeek, id: \.frequency) { day in
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(day.isSelected ? LBColor.buttonGenderEnable : LBColor.backgroundCards)

                            Text(day.name)
                                .font(LBFont.head6)
                                .foregroundColor(day.isSelected ? LBColor.backgroundCards : LBColor.buttonGenderEnable)
                        }
                    }
                }
            }

            if props.addOrEdit == AddOrEditType.edit {
                HStack {
                    LBButton(title: "Cancelar", style: .primaryOff) { props.onClose?() }
                    LBButton(title: "Salvar") {
                        // Here we should submit with formConfig.task
                        print(formConfig.task)
                    }
                }
                } else {
                    LBButton(title: LBStrings.SummaryLocbook.submitTask) {
                        Task {
                            await  model.saveTask(task: props.task)
                            if model.stateTask == .success {
                                props.onSubmit?()
                            }
                        }
                    }
                }
        }
        .padding(.init(top: 24, leading: 24, bottom: 24, trailing: 24))
        .locbookToolbar(
            title: props.title,
            addOrEdit: props.addOrEdit,
            onClose: { props.onClose?() }
        ).onAppear {
            model.iniShifts(shift: props.task.shift)
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
        var task: LocbookTask?
    }
}

extension LocbookSummaryView.Props {

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
                onSubmit: {}, onEditTaskPath: {_ in}, addOrEdit: AddOrEditType.add))
}
