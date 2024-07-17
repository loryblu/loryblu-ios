import Foundation
import Factory

class TasksViewModel: ObservableObject {
    @Injected(\.appData) var appData
    @Published var currentTask: TaskModel?
    @Published var selectedToDelete: LocbookTask = .init()
    private var repository = Container.shared.taskRepository()
    private var cacheTasks: [TaskModel]?
    @Published var tasks: [TaskModel] = []
    @Published var shifts: [ShiftItem] = []
    private var currentSelectedShift: LocbookTask.Shift?
    @Published var currentSelectedDay: LocbookTask.Frequency?
    @Published var currentSelectedDayText: String?
    @Published var filteredTasks: [TaskModel] = []

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
        var taskFiltered: [TaskModel] = []
        currentSelectedDay = weekDays.first ?? .sun
        if weekDays == [] {
            self.tasks = cacheTasks ?? []
        } else {
            taskFiltered = cacheTasks?.filter({ task in
                Set(weekDays).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false && task.locbookTask.shift == currentSelectedShift
            }) ?? []
            self.tasks = taskFiltered
        }
        currentSelectedDayText  = getDayOfWeekName(dayValue: currentSelectedDay)
    }

    func filterByShifts(shiftSelected: String) {
        currentSelectedShift = switch shiftSelected {
        case LBStrings.FrequencyRotine.morning:
            LocbookTask.Shift.morning
        case LBStrings.FrequencyRotine.afternoon:
            LocbookTask.Shift.afternoon
        default:
            LocbookTask.Shift.night
        }
        shifts = shifts.map { (shift: ShiftItem) -> ShiftItem in
            let isSelected = shiftSelected == shift.name ? true : false
            return ShiftItem(
                name: shift.name,
                icon: shift.icon,
                backgroundColor: shift.backgroundColor,
                letterColor: shift.letterColor,
                isSelected: isSelected
            )
        }
        tasks = cacheTasks?.filter({ task in
            Set([currentSelectedDay]).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false && task.locbookTask.shift == currentSelectedShift
        }) ?? []
    }

    func taskToDelete(taskToDelete:LocbookTask) {
        selectedToDelete = taskToDelete
    }
}

// MARK: Extension(s).
extension TasksViewModel {
    func pairDefaultDayNTasks(tasks: [TaskModel]) async ->
    (defaultDay: LocbookTask.Frequency, tasksFiltered: [TaskModel]) {
        var tasksFiltered: [TaskModel]?
        var dayDefault: LocbookTask.Frequency = LocbookTask.Frequency.sun
        let week = [LocbookTask.Frequency.sun,
                    LocbookTask.Frequency.mon,
                    LocbookTask.Frequency.tue,
                    LocbookTask.Frequency.wed,
                    LocbookTask.Frequency.thu,
                    LocbookTask.Frequency.fri,
                    LocbookTask.Frequency.sat]
        var count = 0
        
        while tasksFiltered == nil {
            let actualTasks = tasks.filter({ task in
                Set([week[count]]).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false
            })
            if !actualTasks.isEmpty {
                tasksFiltered = actualTasks
                dayDefault = tasksFiltered != nil ? week[count] : LocbookTask.Frequency.sun
            }
            if count == week.count && tasksFiltered == nil {
                tasksFiltered = []
            }
            count += 1
        }
        return (defaultDay: dayDefault, tasksFiltered: tasksFiltered ?? [])
    }
    func pairDefaultShiftNTasks(tasks: [TaskModel]) async -> (defaultShift: LocbookTask.Shift, tasksFiltered: [TaskModel]) {
        var tasksFiltered: [TaskModel]?
        var shiftDefault: LocbookTask.Shift = LocbookTask.Shift.morning
        let shiftsItems = [
            LocbookTask.Shift.morning,
            LocbookTask.Shift.afternoon,
            LocbookTask.Shift.night
        var tasksFiltered: [TaskModel]?
        var shiftDefault: LocbookTask.Shift = LocbookTask.Shift.morning
        var shiftsItems = [LocbookTask.Shift.morning, LocbookTask.Shift.afternoon, LocbookTask.Shift.night]
        var count = 0
        var count = 0
        var tasksFiltered: [TaskModel]?
        var shiftDefault: LocbookTask.Shift = LocbookTask.Shift.morning
        var shiftsItems = [LocbookTask.Shift.morning, LocbookTask.Shift.afternoon, LocbookTask.Shift.night]
        var count = 0
        while tasksFiltered == nil {
            let actualTasks = tasks.filter({ task in
                task.locbookTask.shift == shiftsItems[count]
            })
            if !actualTasks.isEmpty {
                tasksFiltered = actualTasks
                shiftDefault = tasksFiltered != nil ? shiftsItems[count] : shiftDefault
            }
            if count == shiftsItems.count && tasksFiltered == nil {
                tasksFiltered = []
            }
            count += 1
        }
        return (defaultShift: shiftDefault, tasksFiltered: tasksFiltered ?? [])
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
        let shiftItemsUpdated = items.map { (shift: ShiftItem) -> ShiftItem in
            let shiftText = switch shiftSelected {
            case LocbookTask.Shift.morning:
                LBStrings.FrequencyRotine.morning
            case LocbookTask.Shift.afternoon:
                LBStrings.FrequencyRotine.afternoon
            default:
                LBStrings.FrequencyRotine.night
            }
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
