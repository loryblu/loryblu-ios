import Foundation

struct TaskRequest: Codable {
    var message: String
    var data: [RegisteredTask]
    var count: Int
    var order: Int
    var categoryId: String
    var categoryTitle: String
    var updatedAt: String
}

struct RegisteredTask: Codable {
    var study: [Study]
    var rotine: [Rotine]
}


struct Study: Codable {
    var id : Int
    var shift: Shift
    var frequency: [Frequency]
}

struct Rotine: Codable {
    var id : Int
    var shift: Shift
    var frequency: [Frequency]
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
