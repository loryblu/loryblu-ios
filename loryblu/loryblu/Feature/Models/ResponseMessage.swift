import Foundation

struct ResponseMessage: Decodable {
    var message: String?
    var error: String?
    var statusCode: Int?

    var isError: Bool {
        guard let statusCode = statusCode else {
            return false
        }

        return (200...299).contains(statusCode)
    }

    var isSuccess: Bool {
        guard let statusCode = statusCode else {
            return false
        }

        return (200...299).contains(statusCode)
    }
}
