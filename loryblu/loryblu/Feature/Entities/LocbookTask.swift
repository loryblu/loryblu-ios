import UIKit

struct LocbookTask {
    enum Shift: String, Codable {
        case morning
        case afternoon
        case night
    }

    enum Frequency: String, Codable {
        case sun = "sun"
        case mon = "mon"
        case tue = "tue"
        case wed = "wed"
        case thu = "thu"
        case fri = "fri"
        case sat = "sat"
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
