import UIKit

struct Register: Encodable, Decodable {

    enum Gender: String, Encodable, Decodable {
        case female
        case male
    }

    enum CodingKeys: String, CodingKey {
        case name
        case email
        case password
        case nameChild
        case dateBirth
        case gender
    }

    var name: String?
    var email: String?
    var password: String?
    var nameChild: String?
    var dateBirth: String?
    var gender: Gender?

//    init(name: String, email: String, password: String, nameChild: String, dateBirth: String, gender: Gender) {
//        self.name = name
//        self.email = email
//        self.password = password
//        self.nameChild = nameChild
//        self.dateBirth = dateBirth
//        self.gender = gender
//    }

}

#if DEBUG
extension Register {
    static func fixture(
        name: String = "Maria da Silva",
        email: String = "mariasilva@gmail.com",
        password: String = "123Lori$",
        nameChild: String = "Eduardo Luiz",
        dateBirth: String = "10-08-2018",
        gender: Gender.RawValue = "Masculino"
    ) -> Register {
        Register(
            name: name,
            email: email,
            password: password,
            nameChild: name,
            dateBirth: dateBirth,
            gender: .female)
    }
}
#endif
// swiftlint: enable function_parameter_count
