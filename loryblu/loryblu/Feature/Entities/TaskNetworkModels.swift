import Foundation

struct NetworkDataModel : Decodable {
    var study: [TasksNetworkModel]
    var routine: [TasksNetworkModel]
}

struct TasksNetworkModel : Decodable {
    var id: Int
    var shift: String
    var frequency: [String]
    var order: Int
    var categoryId: String
    var categoryTitle: String
    var updatedAt: String
}

extension [TasksNetworkModel] {
    func toTasksModel(type: String) -> [TaskModel] {
        let taskImages = switch type {
        case LBStrings.Locbook.titleStudy : ListTasks.study
        default :
            ListTasks.rotine
        }
        
        return self.map { (task: TasksNetworkModel) -> TaskModel in
            let shift = getShift(shift:task.shift)
            let frequency = frequencyMapper(frequency:task.frequency)
            let locbooktask = LocbookTask(childrenId: task.id, shift: shift,frequency: frequency, order: task.order, categoryId: task.categoryId,categoryTitle: task.categoryTitle,updatedAt: Date())
            let img = taskImages.filter { label in
                label.categoryID == task.categoryId
            }.first
            
            return task.toTaskModel(actionType: type, locbookTask: locbooktask, img: img!.image)
        }
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
    private func getShift(shift: String) -> LocbookTask.Shift {
        return switch shift {
        case "morning" : LocbookTask.Shift.morning
        case "afternoon" : LocbookTask.Shift.afternoon
        default :
            LocbookTask.Shift.night
        }
    }
}
extension TasksNetworkModel {
    func toTaskModel(actionType:String, locbookTask: LocbookTask, img : String) -> TaskModel {
        return TaskModel(actionType: actionType, locbookTask: locbookTask, image: img)
    }
}
