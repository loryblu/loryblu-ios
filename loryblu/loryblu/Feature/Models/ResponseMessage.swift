import Foundation

struct ResponseMessage: Decodable {
    var message: String?
    var error: String?
    var statusCode: Int?
}
