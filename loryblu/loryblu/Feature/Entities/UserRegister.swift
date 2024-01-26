import UIKit

struct UserRegister: Codable {

    enum Gender: String, Codable {
        case female = "FEMALE"
        case male = "MALE"
    }

    enum CodingKeys: String, CodingKey {
        case parentName
        case email
        case password
        case childrenName
        case childrenBirthDate
        case childrenGender
        case policiesAccepted
    }

    var name: String?
    var email: String?
    var password: String?
    var nameChild: String?
    var dateBirth: String?
    var gender: Gender?
    var agreePrivacy: Bool?

    init(
        name: String? = nil,
        email: String? = nil,
        password: String? = nil,
        nameChild: String? = nil,
        dateBirth: String? = nil,
        gender: Gender? = nil,
        agreePrivacy: Bool? = nil
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.nameChild = nameChild
        self.dateBirth = dateBirth
        self.gender = gender
        self.agreePrivacy = agreePrivacy
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .parentName)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        nameChild = try container.decode(String.self, forKey: .childrenName)
        dateBirth = try container.decode(String.self, forKey: .childrenBirthDate)
        gender = try container.decode(UserRegister.Gender.self, forKey: .childrenGender)
        agreePrivacy = try container.decode(Bool.self, forKey: .policiesAccepted)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.name, forKey: .parentName)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.password, forKey: .password)
        try container.encodeIfPresent(self.nameChild, forKey: .childrenName)
        try container.encodeIfPresent(self.dateBirth, forKey: .childrenBirthDate)
        try container.encodeIfPresent(self.gender?.rawValue, forKey: .childrenGender)
        try container.encodeIfPresent(self.agreePrivacy, forKey: .policiesAccepted)
    }
}

#if DEBUG
extension UserRegister {
    static func fixture(
        name: String = "Maria da Silva",
        email: String = "mariasilva@gmail.com",
        password: String = "123Lori$",
        nameChild: String = "Eduardo Luiz",
        dateBirth: String = "10-08-2018",
        gender: Gender.RawValue = "Masculino",
        agreePrivacy: Bool = true
    ) -> UserRegister {
        UserRegister(
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
