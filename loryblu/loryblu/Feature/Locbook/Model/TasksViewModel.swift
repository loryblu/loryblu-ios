import Foundation
import Factory

class TasksViewModel: ObservableObject {
    @Injected(\.appData) var appData
    @Published var currentTask: TaskModel?
    @Published var selectedToDelete: LocbookTask = .init()
    @Published var tasks: [TaskModel] = []
    @Published var shifts: [ShiftItem] = []
    @Published var currentSelectedDay: LocbookTask.Frequency?
    @Published var currentSelectedDayText: String?
    @Published var filteredTasks: [TaskModel] = []
    private var repository = Container.shared.taskRepository()
    private var cacheTasks: [TaskModel]?
    private var currentSelectedShift: LocbookTask.Shift?

    var forceReload: Bool {
        appData.forceReloadListView
    }

    @MainActor
    func fetchTasks() async {
        if cacheTasks == nil || forceReload {
            cacheTasks = await repository.fetchTasks(token: appData.token, childrenId: appData.childrenId)
            let pairDay = await pairDefaultDayNTasks(tasks: cacheTasks ?? [])
            let pairShift = await pairDefaultShiftNTasks(tasks: pairDay.tasksFiltered)
            currentSelectedDay = pairDay.defaultDay
            currentSelectedShift = pairShift.defaultShift
            shifts = getShiftsSelectedByDefault(shiftSelected: pairShift.defaultShift)
            tasks = pairShift.tasksFiltered
            appData.forceReloadListView = false
        }

        filterWeekDay(weekDays: [currentSelectedDay ?? LocbookTask.Frequency.sun])
        currentSelectedDayText  = getDayOfWeekName(dayValue: currentSelectedDay)
    }

    func filterWeekDay(weekDays: [LocbookTask.Frequency]) {
        guard !weekDays.isEmpty else {
            self.tasks = cacheTasks ?? []
            return
        }

        currentSelectedDay = weekDays.first ?? .sun

        tasks = cacheTasks?.filter { task in
            let taskFrequencies = Set(task.locbookTask.frequency ?? [])
            return !taskFrequencies.isDisjoint(with: weekDays) && task.locbookTask.shift == currentSelectedShift
        } ?? []

        currentSelectedDayText = getDayOfWeekName(dayValue: currentSelectedDay)
    }

    func filterByShifts(shiftSelected: String) {
        currentSelectedShift = {
            switch shiftSelected {
            case LBStrings.FrequencyRotine.morning:
                return LocbookTask.Shift.morning
            case LBStrings.FrequencyRotine.afternoon:
                return LocbookTask.Shift.afternoon
            default:
                return LocbookTask.Shift.night
            }
        }()

        shifts = shifts.map { shift in
            let isSelected = shiftSelected == shift.name
            return ShiftItem(
                name: shift.name,
                icon: shift.icon,
                backgroundColor: shift.backgroundColor,
                letterColor: shift.letterColor,
                isSelected: isSelected
            )
        }

        guard let currentDay = currentSelectedDay else {
            tasks = cacheTasks ?? []
            return
        }

        tasks = cacheTasks?.filter { task in
            let taskFrequencies = Set(task.locbookTask.frequency ?? [])
            return !taskFrequencies.isDisjoint(with: [currentDay]) && task.locbookTask.shift == currentSelectedShift
        } ?? []
    }

    func taskToDelete(taskToDelete: LocbookTask) {
        selectedToDelete = taskToDelete
    }
}

// MARK: Extension(s).
extension TasksViewModel {
    func pairDefaultDayNTasks(tasks: [TaskModel]) async -> (
        defaultDay: LocbookTask.Frequency,
        tasksFiltered: [TaskModel]) {

        let week: [LocbookTask.Frequency] = [
            .sun, .mon, .tue, .wed, .thu, .fri, .sat
        ]

        for day in week {
            let tasksFiltered = tasks.filter { task in
                let taskFrequencies = Set(task.locbookTask.frequency ?? [])
                return !taskFrequencies.isSubset(of: [day])
            }

            if !tasksFiltered.isEmpty {
                return (defaultDay: day, tasksFiltered: tasksFiltered)
            }
        }

        return (defaultDay: .sun, tasksFiltered: [])
    }

    func pairDefaultShiftNTasks(tasks: [TaskModel]) async -> (
        defaultShift: LocbookTask.Shift,
        tasksFiltered: [TaskModel]) {

        let shiftsItems: [LocbookTask.Shift] = [
            .morning, .afternoon, .night
        ]

        for shift in shiftsItems {
            let tasksFiltered = tasks.filter { task in
                task.locbookTask.shift == shift
            }

            if !tasksFiltered.isEmpty {
                return (defaultShift: shift, tasksFiltered: tasksFiltered)
            }
        }

        return (defaultShift: shiftsItems.first ?? .morning, tasksFiltered: [])
    }

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
        let shiftText: String

        switch shiftSelected {
        case LocbookTask.Shift.morning:
            shiftText = LBStrings.FrequencyRotine.morning
        case LocbookTask.Shift.afternoon:
            shiftText = LBStrings.FrequencyRotine.afternoon
        default:
            shiftText = LBStrings.FrequencyRotine.night
        }

        let shiftItemsUpdated = items.map { shift in
            ShiftItem(
                name: shift.name,
                icon: shift.icon,
                backgroundColor: shift.backgroundColor,
                letterColor: shift.letterColor,
                isSelected: shift.name == shiftText
            )
        }

        return shiftItemsUpdated
    }

    func getDayOfWeekName(dayValue: LocbookTask.Frequency?) -> String {
        switch dayValue {
        case .sun:
            LBStrings.DaysOfWeek.sunday
        case .mon:
            LBStrings.DaysOfWeek.monday
        case .tue:
            LBStrings.DaysOfWeek.tuesday
        case .wed:
            LBStrings.DaysOfWeek.wednesday
        case .thu:
            LBStrings.DaysOfWeek.thursday
        case .fri:
            LBStrings.DaysOfWeek.friday
        case .sat:
            LBStrings.DaysOfWeek.saturday
        case .none:
            LBStrings.DaysOfWeek.sunday
        }
    }
}
