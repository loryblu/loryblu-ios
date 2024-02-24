import Foundation
import Factory

class TasksViewModel: ObservableObject {
     @Injected(\.appData) var appData
     
    private var repository = Container.shared.taskRepository()

    @Published var tasks: [TaskModel] = []
    private var listTask: [TaskModel] = []

    @MainActor
    func fetchTasks() async {
        listTask = await repository
             .fetchTasks(token: appData.token,childrenId: appData.childrenId)
        tasks = listTask
    }

    func filterWeekDay(weekDays: [LocbookTask.Frequency]) {
           var taskFiltered: [TaskModel] = []

extension TasksViewModel {
    func pairDefaultDayNTasks(tasks: [TaskModel]) async ->
    (defaultDay: LocbookTask.Frequency, tasksFiltered: [TaskModel]) {
        var tasksFilted: [TaskModel]?
        var dayDefault: LocbookTask.Frequency?
        let week = [LocbookTask.Frequency.sun,
                    LocbookTask.Frequency.mon,
                    LocbookTask.Frequency.tue,
                    LocbookTask.Frequency.wed,
                    LocbookTask.Frequency.thu,
                    LocbookTask.Frequency.fri,
                    LocbookTask.Frequency.sat]
        var count = 0
        while(tasksFilted == nil) {
            let actualTasks = tasks.filter({ task in
                Set([week[count]]).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false
            })
            if(!actualTasks.isEmpty) {
                tasksFilted = tasks
            }
            if(count == week.count && tasksFilted == nil) {
                tasksFilted = []
            }
            dayDefault = tasksFilted != nil ? week[count] : LocbookTask.Frequency.sun
            count += 1
        }
        return (defaultDay: dayDefault!, tasksFiltered: tasksFilted ?? [])
    }
}
