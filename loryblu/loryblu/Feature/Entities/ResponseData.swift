import Foundation

struct ResponseData <T : Decodable>: Decodable {
     var message: String?
     var data: T?
     var error: String?
     var statusCode: Int?

     var isSuccess: Bool {
         guard let statusCode = statusCode else {
             return true
         }

         return (200...299).contains(statusCode)
     }
 }
