import Foundation

struct NetworkDataModel : Decodable {
     var study: [TasksNetworkModel]
     var routine: [TasksNetworkModel]
 }

 struct TasksNetworkModel : Decodable {
     var id: Int
     var shift: String
     var frequency: [String]
     var order: Int
     var categoryId: String
     var categoryTitle: String
     var updatedAt: String
 }
