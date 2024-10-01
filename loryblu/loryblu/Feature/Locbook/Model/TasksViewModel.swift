import Foundation
import Factory

class TasksViewModel: ObservableObject {
    @Injected(\.appData) var appData
    @Published var currentTask: TaskModel?
    @Published var taskToDelete: LocbookTask = .init()
    @Published var deleteOptionTitle: String?
    @Published var taskFilter: TaskFilter?
    @Published var shifts: [ShiftItem] = []
    @Published var displayDeleteMsgSuccessful: Bool = false
    @Published var openDeleteDialog: Bool = false
    private var repository = Container.shared.taskRepository()
    private var currentSelectedShift: LocbookTask.Shift?
    @Published private var cacheTasks: [Int: TaskModel] = [:]

    @MainActor
    func fetchTasks() async {
        cacheTasks = await repository.fetchTasks(
            token: appData.token,
            childrenId: appData.childrenId
        )

        let taskFilterBuilder = TaskFilterBuilder()
        taskFilterBuilder.setupFilter(tasks: cacheTasks)
        taskFilter = taskFilterBuilder.build()
        shifts = getShiftsSelectedByDefault(
            shiftSelected: taskFilter?.shift ?? LocbookTask.Shift.morning
        )
    }

    func removeTask(deleteOption: DeleteOption) {
        Task { @MainActor in
            switch deleteOption {
            case DeleteOption.allDays:
                let result = await repository.deleteTask(
                    token: appData.token,
                    childrenId: appData.childrenId,
                    taskId: taskToDelete.id
                )

                if result {
                   deleteOptionTitle = LBStrings.General.allDays
                   switchMsgDialogState()
                   switchDeleteDialogState()
                   updateUiState()
                    cacheTasks = await repository.fetchTasks(
                        token: appData.token,
                        childrenId: appData.childrenId
                    )
               } else {
                   switchDeleteDialogState()
               }

            default:
                let taskEdited = getTaskEdited()
                let result = await repository.taskEdit(
                    with: taskEdited,
                    token: appData.token,
                    childrenID: appData.childrenId
                )

                if result {
                    deleteOptionTitle = taskFilter?.dayText
                    switchMsgDialogState()
                    switchDeleteDialogState()
                    updateUiState()
                    cacheTasks = await repository.fetchTasks(
                        token: appData.token,
                        childrenId: appData.childrenId
                    )
                } else {
                    switchDeleteDialogState()
                }
            }
        }
    }

    func closeDeleteDialog() {
        switchDeleteDialogState()
    }

    func closeDeleteSuccessfulMsg() {
        switchMsgDialogState()
        resetTaskToDelete()
    }

    func filterByShifts(shiftSelected: String) {
        currentSelectedShift = {
            switch shiftSelected {
            case LBStrings.FrequencyRotine.morning:
                LocbookTask.Shift.morning
            case LBStrings.FrequencyRotine.afternoon:
                LocbookTask.Shift.afternoon
            default:
                LocbookTask.Shift.night
            }
        }()

        shifts = shifts.map { (shift: ShiftItem) -> ShiftItem in
            let isSelected = shiftSelected == shift.name
            return ShiftItem(
                name: shift.name,
                icon: shift.icon,
                backgroundColor: shift.backgroundColor,
                letterColor: shift.letterColor,
                isSelected: isSelected
            )
        }

        taskFilter = taskFilter?.filterByShift(
            shift: currentSelectedShift ?? LocbookTask.Shift.morning,
            allTasks: cacheTasks
        )
    }

    func filterWeekDay(weekDays: [LocbookTask.Frequency]) {
        taskFilter = taskFilter?.filterByWeekDay(weekDays: weekDays, allTasks: cacheTasks)
    }

    func openDeleteOptions(selectedTask: LocbookTask) {
        setupTaskToDelete(selectedTask: selectedTask)
        switchDeleteDialogState()
    }
}

extension TasksViewModel {

    private func switchMsgDialogState() {
        displayDeleteMsgSuccessful = !displayDeleteMsgSuccessful
    }

    private func setupTaskToDelete(selectedTask: LocbookTask) {
        taskToDelete = selectedTask
    }

    private func switchDeleteDialogState() {
        openDeleteDialog = !openDeleteDialog
    }

    private func getTaskEdited() -> LocbookTask {
        let newFrequency = getNewFrequency()
        return LocbookTask(
            id: taskToDelete.id,
            childrenId: appData.childrenId,
            shift: taskToDelete.shift,
            frequency: newFrequency,
            categoryId: taskToDelete.categoryId,
            categoryTitle: taskToDelete.categoryTitle,
            taskTitle: taskToDelete.taskTitle
        )
    }

    private func getNewFrequency() -> [LocbookTask.Frequency] {
        var oldFrequency = taskToDelete.frequency
        oldFrequency?.removeAll(where: { $0 == taskFilter?.day })
        return oldFrequency ?? []
    }

    private func updateUiState() {
        taskFilter = taskFilter?.removeById(taskId: taskToDelete.id)
    }

    private func resetTaskToDelete() {
        taskToDelete = .init()
    }

}

extension TasksViewModel {
    func getShiftsSelectedByDefault(shiftSelected: LocbookTask.Shift) -> [ShiftItem] {
        let items = [
            ShiftItem(
                name: LBStrings.FrequencyRotine.morning,
                icon: LBIcon.sunSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundLight,
                letterColor: .black,
                isSelected: false),
            ShiftItem(
                name: LBStrings.FrequencyRotine.afternoon,
                icon: LBIcon.eviningSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundMedium,
                letterColor: .white, isSelected: false),
            ShiftItem(
                name: LBStrings.FrequencyRotine.night,
                icon: LBIcon.moonSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundDark,
                letterColor: .white, isSelected: false)
        ]

        let shiftItemsUpdated = items.map { (shift: ShiftItem) -> ShiftItem in
            let shiftText = {
                switch shiftSelected {
                case LocbookTask.Shift.morning:
                    LBStrings.FrequencyRotine.morning
                case LocbookTask.Shift.afternoon:
                    LBStrings.FrequencyRotine.afternoon
                default:
                    LBStrings.FrequencyRotine.night
                }
            }()

            let isSelected = shiftText == shift.name ? true : false
            return ShiftItem(
                name: shift.name,
                icon: shift.icon,
                backgroundColor: shift.backgroundColor,
                letterColor: shift.letterColor,
                isSelected: isSelected
            )
        }
        return shiftItemsUpdated
    }
}
