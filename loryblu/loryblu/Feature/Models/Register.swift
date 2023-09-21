import UIKit

struct Register: Encodable {

    enum Gender: String, Encodable {
        case female = "FEMALE"
        case male = "MALE"
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
    var agreePrivacy: Bool?

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.password, forKey: .password)
        try container.encodeIfPresent(self.nameChild, forKey: .nameChild)
        try container.encodeIfPresent(self.dateBirth, forKey: .dateBirth)
        try container.encodeIfPresent(self.gender?.rawValue, forKey: .gender)
    }

}

#if DEBUG
extension Register {
    static func fixture(
        name: String = "Maria da Silva",
        email: String = "mariasilva@gmail.com",
        password: String = "123Lori$",
        nameChild: String = "Eduardo Luiz",
        dateBirth: String = "10-08-2018",
        gender: Gender.RawValue = "Masculino",
        agreePrivacy: Bool = true
    ) -> Register {
        Register(
            name: name,
            email: email,
            password: password,
            nameChild: name,
            dateBirth: dateBirth,
            gender: .male,
            agreePrivacy: true
        )
    }
}
#endif
