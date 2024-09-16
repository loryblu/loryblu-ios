import UIKit
import SwiftUI

struct LocbookTask {
    enum Shift: String, Codable {
        case morning
        case afternoon
        case night
    }

    enum Frequency: String, Codable {
        case sun, mon, tue, wed, thu, fri, sat
    }

    var id: Int?
    var childrenId: Int?
    var shift: Shift?
    var frequency: [Frequency]?
    var order: Int?
    var categoryId: String?
    var categoryTitle: String?
    var taskTitle: String?
    var updatedAt: Date?

    init(
        id: Int? = nil,
        childrenId: Int? = nil,
        shift: Shift? = nil,
        frequency: [Frequency]? = nil,
        order: Int? = nil,
        categoryId: String? = nil,
        categoryTitle: String? = nil,
        taskTitle: String? = nil,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.childrenId = childrenId
        self.shift = shift
        self.frequency = frequency
        self.order = order
        self.categoryId = categoryId
        self.categoryTitle = categoryTitle
        self.taskTitle = taskTitle
        self.updatedAt = updatedAt
    }
}

extension LocbookTask {
    func toTaskModel() -> TaskModel {
        let backgroundCardColor: Color

        switch shift {
        case .morning:
            backgroundCardColor = LBColor.buttonBackgroundLight
        case .afternoon:
            backgroundCardColor = LBColor.buttonBackgroundMedium
        default:
            backgroundCardColor = LBColor.buttonBackgroundDark
        }
        
        let taskImages = categoryTitle == LBStrings.Locbook.titleStudy ? ListTasks.study : ListTasks.rotine

        let img = taskImages.filter { label in
            label.categoryID == self.categoryId
        }.first!.image

        return TaskModel(
            locbookTask: self,
            image: img,
            backgroundCard: backgroundCardColor
        )
    }
}
