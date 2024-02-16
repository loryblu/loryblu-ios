import Foundation

struct TaskRequest: Codable {
    var message: String
    var data: RegisteredTask

}

struct RegisteredTask: Codable {
    var count: Int
    var study: [Study]
    var rotine: [Rotine]
}

struct Study: Codable, Identifiable {
    var id : Int
    var shift: Shift
    var frequency: [Frequency]
    var order: Int
    var categoryId: String
    var categoryTitle: String
    var updatedAt: String
}

struct Rotine: Codable, Identifiable {
    var id : Int
    var shift: Shift
    var frequency: [Frequency]
    var order: Int
    var categoryId: String
    var categoryTitle: String
    var updatedAt: String
}

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
