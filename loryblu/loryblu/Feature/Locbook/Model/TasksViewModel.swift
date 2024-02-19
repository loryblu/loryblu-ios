import Foundation
import Factory

 class TasksViewModel: ObservableObject {

     @Injected(\.appData) var appData
     
     private var repository = Container.shared.taskRepository()

     @Published var tasks: [TaskModel] = []

     @MainActor
     func fetchTasks() async {

         tasks = await repository
             .fetchTasks(token: appData.token,childrenId: appData.childrenId)

     }
 }
