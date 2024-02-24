import Foundation
import Factory

class TasksViewModel: ObservableObject {
    @Injected(\.appData) var appData
    private var repository = Container.shared.taskRepository()
    private var cacheTasks: [TaskModel]?
    @Published var tasks: [TaskModel] = []
    @Published var shifts: [ShiftItem] = []
    private var currentSelectedShift: LocbookTask.Shift?
    @Published var currentSelectedDay: LocbookTask.Frequency?
    @Published var filteredTasks: [TaskModel] = []
    @MainActor
    func fetchTasks() async {
         
        if(cacheTasks == nil) {
            cacheTasks = await repository.fetchTasks(token: appData.token, childrenId: appData.childrenId)
            let pairDay = await pairDefaultDayNTasks(tasks: cacheTasks ?? [])
            let pairShift = await pairDefaultShiftNTasks(tasks: pairDay.tasksFiltered)
            currentSelectedDay = pairDay.defaultDay
            currentSelectedShift = pairShift.defaultShift
            shifts = getShiftsSelectedByDefault(shiftSelected: pairShift.defaultShift)
            tasks = pairShift.tasksFiltered
        } else {
            filterWeekDay(weekDays: [currentSelectedDay ?? LocbookTask.Frequency.sun])
        }
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
}

extension TasksViewModel {
    func pairDefaultDayNTasks(tasks: [TaskModel]) async ->
    (defaultDay: LocbookTask.Frequency, tasksFiltered: [TaskModel]) {
        var tasksFiltered: [TaskModel]?
        var dayDefault: LocbookTask.Frequency?
        let week = [LocbookTask.Frequency.sun,
                    LocbookTask.Frequency.mon,
                    LocbookTask.Frequency.tue,
                    LocbookTask.Frequency.wed,
                    LocbookTask.Frequency.thu,
                    LocbookTask.Frequency.fri,
                    LocbookTask.Frequency.sat]
        var count = 0
        while(tasksFiltered == nil) {
            let actualTasks = tasks.filter({ task in
                Set([week[count]]).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false
            })
            if(!actualTasks.isEmpty) {
                tasksFiltered = actualTasks
            }
            if(count == week.count && tasksFiltered == nil) {
                tasksFiltered = []
            }
            dayDefault = tasksFiltered != nil ? week[count] : LocbookTask.Frequency.sun
            count += 1
        }
        return (defaultDay: dayDefault!, tasksFiltered: tasksFiltered ?? [])
    }
    func pairDefaultShiftNTasks(tasks: [TaskModel]) async -> (defaultShift: LocbookTask.Shift, tasksFiltered: [TaskModel]) {
        var tasksFiltered: [TaskModel]?
        var shiftDefault: LocbookTask.Shift = LocbookTask.Shift.morning
        var shiftsItems = [LocbookTask.Shift.morning, LocbookTask.Shift.afternoon, LocbookTask.Shift.night]
        var count = 0
        while(tasksFiltered == nil) {
            let actualTasks = tasks.filter({ task in
                task.locbookTask.shift == shiftsItems[count]
            })
            if(!actualTasks.isEmpty) {
                tasksFiltered = actualTasks
            }
            if(count == shiftsItems.count && tasksFiltered == nil) {
                tasksFiltered = []
            }
            shiftDefault = tasksFiltered != nil ? shiftsItems[count] : shiftDefault
            count += 1
        }
        return (defaultShift: shiftDefault, tasksFiltered: tasksFiltered ?? [])
    }
    func getShiftsSelectedByDefault(shiftSelected: LocbookTask.Shift) -> [ShiftItem] {
        var items = [ShiftItem(
            name: LBStrings.FrequencyRotine.morning,
            icon: LBIcon.sunSmall.rawValue,
            backgroundColor: LBColor.buttonBackgroundLight,
            letterColor: .black, isSelected: false),
                     ShiftItem(
                        name: LBStrings.FrequencyRotine.afternoon,
                        icon: LBIcon.eviningSmall.rawValue,
                        backgroundColor: LBColor.buttonBackgroundMedium,
                        letterColor: .white, isSelected: false),
                     ShiftItem(
                        name: LBStrings.FrequencyRotine.night,
                        icon: LBIcon.moonSmall.rawValue,
                        backgroundColor: LBColor.buttonBackgroundDark,
                        letterColor: .white, isSelected: false)]
        return items.map { (shift: ShiftItem) -> ShiftItem in
            let shiftText = switch shiftSelected {
            case LocbookTask.Shift.morning:
                LBStrings.FrequencyRotine.morning
            case LocbookTask.Shift.afternoon:
                LBStrings.FrequencyRotine.afternoon
            default:
                LBStrings.FrequencyRotine.night
            }
            var isSelected = shiftText == shift.name ? true : false
            return ShiftItem(
                name: shift.name,
                icon: shift.icon,
                backgroundColor: shift.backgroundColor,
                letterColor: shift.letterColor,
                isSelected: isSelected
            )
        }
    }
}
