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
        
        taskFiltered = listTask.filter({ task in
            if let 
            Set(weekDays).intersection(Set(task.locbookTask.frequency ?? [])).isEmpty == false
        })

        self.tasks = taskFiltered
        print(taskFiltered.map {
            $0.locbookTask.frequency
        })
    }

}
