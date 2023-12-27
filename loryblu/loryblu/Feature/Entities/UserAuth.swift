import Foundation

struct UserAuth {
    var data: String
    var accessToken: String
    var refreshToken: String
    var user: User

    struct User {
        var pid: String
        var parentName: String
        var childrens: [Childrens]
    }

    struct Childrens {
        var id: Int
        var fullname: String
        var gender: Gender
        var birthdate: Date

        enum Gender {
            case male
            case female
        }
    }
}

