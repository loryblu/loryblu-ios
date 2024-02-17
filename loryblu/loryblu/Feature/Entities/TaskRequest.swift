import Foundation

struct TaskRequest: Decodable {
    var message: String
    var data: RegisteredTask?
}

struct RegisteredTask: Decodable {
    var count: Int
    var study: [Study]
    var routine: [Rotine]
}

struct Study: Decodable, Identifiable {
    var id : Int
    var shift: Shift
    var frequency: [Frequency]
    var order: Int
    var categoryId: String
    var categoryTitle: String
    var updatedAt: String
}

struct Rotine: Decodable, Identifiable {
    var id : Int
    var shift: Shift
    var frequency: [Frequency]
    var order: Int
    var categoryId: String
    var categoryTitle: String
    var updatedAt: String
}

enum Shift: String, Decodable {
    case morning
    case afternoon
    case night
}

enum Frequency: String, Decodable {
    case sun = "sun"
    case mon = "mon"
    case tue = "tue"
    case wed = "wed"
    case thu = "thu"
    case fri = "fri"
    case sat = "sat"
}
