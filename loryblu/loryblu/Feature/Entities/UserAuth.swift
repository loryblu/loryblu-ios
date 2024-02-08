import Foundation

struct UserAuth: Codable {
    var message: String
    var data: DataUser
}

struct DataUser: Codable {
    var accessToken: String
    var refreshToken: String
    var user: User
}

struct User: Codable {
    var pid: String
    var parentName: String
    var children: [Child]
}

struct Child: Codable {
    var id: Int
    var fullname: String
    var gender: String
    var birthdate: String
}
