import Foundation

struct UserAuth: Codable {
    var data: String
    var accessToken: String
    var refreshToken: String
    var user: User

    struct User: Codable {
        var pid: String
        var parentName: String
        var childrens: [Childrens]
    }

    struct Childrens: Codable {
        var id: Int
        var fullname: String
        var gender: Gender
        var birthdate: Date

        enum Gender: Codable{
            case male
            case female
        }
    }
}

