import Foundation
import SwiftUI

struct NetworkDataModel: Decodable {
    var study: [TasksNetworkModel]
    var routine: [TasksNetworkModel]
}

struct TasksNetworkModel: Decodable {
    var id: Int
    var shift: String
    var frequency: [String]
    var order: Int
    var categoryId: String
    var categoryTitle: String
    var updatedAt: String
}

extension [TasksNetworkModel] {
    func toTasksModel(category: String) -> [TaskModel] {
        let taskImages = category == LBStrings.Locbook.titleStudy ? ListTasks.study : ListTasks.rotine
        
        return self.map { (task: TasksNetworkModel) -> TaskModel in
            let shift = getShift(shift: task.shift)
            let frequency = frequencyMapper(frequency: task.frequency)
            let locbooktask = LocbookTask(
                id: task.id,
                shift: shift,
                frequency: frequency,
                order: task.order,
                categoryId: task.categoryId,
                categoryTitle: category,
                taskTitle: task.categoryTitle,
                updatedAt: Date()
            )

            let img = taskImages.filter { label in
                label.categoryID == task.categoryId
            }.first

            return task.toTaskModel(locbookTask: locbooktask, img: img!.image)
        }
    }

    private func frequencyMapper(frequency: [String]) -> [LocbookTask.Frequency] {
        return frequency.map { (item: String) -> LocbookTask.Frequency in
            return getFrequency(frequency: item)
        }
    }

    private func getFrequency(frequency: String) -> LocbookTask.Frequency {
        switch frequency {
        case "sun":
            return LocbookTask.Frequency.sun
        case "mon":
            return LocbookTask.Frequency.mon
        case "tue":
            return LocbookTask.Frequency.tue
        case "wed":
            return LocbookTask.Frequency.wed
        case "thu":
            return LocbookTask.Frequency.thu
        case "fri":
            return LocbookTask.Frequency.fri
        default:
            return LocbookTask.Frequency.sat
        }
    }

    private func getShift(shift: String) -> LocbookTask.Shift {
        LocbookTask.Shift(rawValue: shift) ?? .night
    }
}

extension TasksNetworkModel {
    func toTaskModel(locbookTask: LocbookTask, img: String) -> TaskModel {
        let backgroundCardColor: Color

        switch locbookTask.shift {
        case .morning:
            backgroundCardColor = LBColor.buttonBackgroundLight
        case .afternoon:
            backgroundCardColor = LBColor.buttonBackgroundMedium
        default:
            backgroundCardColor = LBColor.buttonBackgroundDark
        }

        return TaskModel(
            locbookTask: locbookTask,
            image: img,
            backgroundCard: backgroundCardColor
        )
    }
}
