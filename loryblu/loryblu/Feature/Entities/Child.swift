import Foundation

struct Child: Identifiable {
    var id: ObjectIdentifier?

    let name: String
    let dateBirth: String
    let gender: String

}

#if DEBUG
extension Child {
    static func fixture(
        name: String = "Miguel",
        dateBirth: String = "01-01-2018",
        gender: Gender = .male,
        id: ObjectIdentifier?
    ) -> Child {
        Child(id: id, name: name, dateBirth: dateBirth, gender: gender.rawValue)
    }
}
#endif
