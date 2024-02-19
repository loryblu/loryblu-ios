import Foundation
import Factory

class TasksViewModel: ObservableObject {
     @Injected(\.appData) var appData
     
     private var repository = Container.shared.taskRepository()

     @Published var tasks: [TaskModel] = []

     @MainActor
     func fetchTasks() async {
         tasks = await repository
             .fetchTasks(token: appData.token,childrenId: appData.childrenId)
     }

    func filterWeekDay(weekDays: String, listTask: [TaskModel]) -> [TaskModel] {
        var taskFiltered: [TaskModel] = []
        for task in listTask {
            if let frequency = task.locbookTask.frequency {
                for day in frequency {
                    if day == getFrequency(frequency: weekDays) {
                        taskFiltered.append(task)
                    }
                }
            }
        }
        return taskFiltered
    }

    private func frequencyMapper(frequency: [String]) -> [LocbookTask.Frequency] {
        return frequency.map { (item: String) -> LocbookTask.Frequency in
            return getFrequency(frequency:item)
        }
    }

    private func getFrequency(frequency: String) -> LocbookTask.Frequency {
        return switch frequency {
        case "sun" : LocbookTask.Frequency.sun
        case "mon" : LocbookTask.Frequency.mon
        case "tue" : LocbookTask.Frequency.tue
        case "wed" : LocbookTask.Frequency.wed
        case "thu" : LocbookTask.Frequency.thu
        case "fri" : LocbookTask.Frequency.fri
        default : LocbookTask.Frequency.sat
        }
    }

 }
