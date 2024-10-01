import Foundation

class TaskFilterBuilder {

    private var taskFilter: TaskFilter = TaskFilter()

    func setupFilter(tasks: [Int: TaskModel]) {
        let day = pairDefaultDayNTasks(tasks: Array(tasks.values))
        taskFilter.day = day.defaultDay

        let shift = pairDefaultShiftNTasks(tasks: day.tasksFiltered)
        taskFilter.shift = shift.defaultShift
        taskFilter.tasks = shift.tasksFiltered
        taskFilter.filterByWeekDay(
            weekDays: [taskFilter.day ?? LocbookTask.Frequency.sun],
            allTasks: tasks
        )
    }

    func build() -> TaskFilter {
        return self.taskFilter
    }
}

extension TaskFilterBuilder {
    func pairDefaultDayNTasks(
        tasks: [TaskModel]) -> (
            defaultDay: LocbookTask.Frequency, tasksFiltered: [TaskModel]
        ) {
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
                let actualTasks = tasks.filter { task in
                    guard let frequencies = task.locbookTask.frequency else { return false }
                    return frequencies.contains(week[count])
                }

                if !actualTasks.isEmpty {
                    tasksFiltered = actualTasks
                    dayDefault = tasksFiltered != nil ? week[count] : LocbookTask.Frequency.sun
                }

                if count == week.count - 1 && tasksFiltered == nil {
                    tasksFiltered = []
                }
                count += 1

            }
            return (defaultDay: dayDefault, tasksFiltered: tasksFiltered ?? [])
    }

    func pairDefaultShiftNTasks(tasks: [TaskModel]) -> (defaultShift: LocbookTask.Shift, tasksFiltered: [TaskModel]) {
        var tasksFiltered: [TaskModel]?
        var shiftDefault: LocbookTask.Shift = LocbookTask.Shift.morning
        let shiftsItems = [
            LocbookTask.Shift.morning,
            LocbookTask.Shift.afternoon,
            LocbookTask.Shift.night]
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
}
