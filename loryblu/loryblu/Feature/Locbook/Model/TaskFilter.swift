import Foundation

class TaskFilter {
    var day: LocbookTask.Frequency?
    var dayText: String?
    var shift: LocbookTask.Shift?
    var tasks: [TaskModel] = []
    
    init(day: LocbookTask.Frequency? = nil, dayText: String? = nil, shift: LocbookTask.Shift? = nil, tasks: [TaskModel] = []) {
        self.day = day
        self.dayText = dayText
        self.shift = shift
        self.tasks = tasks
    }
    
    func filterByShift(shift: LocbookTask.Shift, allTasks: [Int: TaskModel]) -> TaskFilter {
        tasks = allTasks.values.filter({ task in
            Set([day]).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false && task.locbookTask.shift == shift
        })
        return getCurrentFilterState()
    }
    
    func filterByWeekDay(weekDays: [LocbookTask.Frequency], allTasks: [Int: TaskModel]) -> TaskFilter {
        var taskFiltered: [TaskModel] = []
        day = weekDays.first ?? .sun
        if weekDays == [] {
            tasks = Array(allTasks.values)
        } else {
            taskFiltered = allTasks.values.filter({ task in
                Set(weekDays).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false && task.locbookTask.shift == shift
            })
            tasks = taskFiltered
        }
        dayText  = getDayOfWeekName(dayValue: self.day)
        return getCurrentFilterState()
    }
    
    func removeById(taskId: Int?) -> TaskFilter {
        do {
            tasks.removeAll(where: { $0.locbookTask.id == taskId! })
        }
        return getCurrentFilterState()
    }
    
    private func getCurrentFilterState() -> TaskFilter {
        return TaskFilter(
            day: day,
            dayText: getDayOfWeekName(dayValue: day),
            shift: shift,
            tasks: tasks
        )
    }
    
    private func getDayOfWeekName(dayValue: LocbookTask.Frequency?) -> String {
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
