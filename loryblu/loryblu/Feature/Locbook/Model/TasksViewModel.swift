import Foundation
import Factory

class TasksViewModel: ObservableObject {
    @Injected(\.appData) var appData

    private var repository = Container.shared.taskRepository()

    @Published var tasks: [TaskModel] = []
    var listTask: [TaskModel] = []

    @MainActor
    func fetchTasks() async {

        listTask = await repository
            .fetchTasks(token: appData.token,childrenId: appData.childrenId)
        tasks = listTask
    }

    func filterWeekDay(weekDays: [LocbookTask.Frequency]) {
        var taskFiltered: [TaskModel] = []

        if weekDays == [] {
            self.tasks = listTask
        } else {
            taskFiltered = listTask.filter({ task in
                Set(weekDays).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false
            })
            self.tasks = taskFiltered
        }
    }
}
