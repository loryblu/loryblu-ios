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

    func getFirstDayWithTask() -> LBFrequencyFilter.Week {

        let days = ["sun","mon","tue","wed","thu","fri","sat"]

        if !listTask.isEmpty {
            for day in days {
                for task in listTask {
                    if ((task.locbookTask.frequency?.contains(getFrequency(frequency: day))) != nil) {
                        return  getWeekday(frequency: getFrequency(frequency: day))
                    }
                }
            }
        }
        return .none
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

    private func getWeekday(frequency: LocbookTask.Frequency) -> LBFrequencyFilter.Week {
        return switch frequency {
        case LocbookTask.Frequency.sun : LBFrequencyFilter.Week.sunday
        case LocbookTask.Frequency.mon : LBFrequencyFilter.Week.monday
        case LocbookTask.Frequency.tue : LBFrequencyFilter.Week.tuesday
        case LocbookTask.Frequency.wed : LBFrequencyFilter.Week.wednesday
        case LocbookTask.Frequency.thu : LBFrequencyFilter.Week.thurday
        case LocbookTask.Frequency.fri : LBFrequencyFilter.Week.friday
        default : LBFrequencyFilter.Week.satuday
        }
    }
}
