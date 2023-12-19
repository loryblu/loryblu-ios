import UIKit

struct LocbookTask {
    enum Shift {
        case morning
        case afternoon
        case night
    }

    enum Frequency {
        case sun
        case mon
        case tue
        case wed
        case thu
        case fri
        case sat
    }

    var childrenId: Int?
    var shift: Shift?
    var frequency: [Frequency]?
    var order: Int?
    var categoryId: String?
    var categoryTitle: String?
    var updatedAt: Date?

    init(
        childrenId: Int? = nil,
        shift: Shift? = nil,
        frequency: [Frequency]? = nil,
        order: Int? = nil,
        categoryId: String? = nil,
        categoryTitle: String? = nil,
        updatedAt: Date? = nil
    ) {
        self.childrenId = childrenId
        self.shift = shift
        self.frequency = frequency
        self.order = order
        self.categoryId = categoryId
        self.categoryTitle = categoryTitle
        self.updatedAt = updatedAt
    }
}
