import Foundation
import Factory
class LocbookListModel: ObservableObject {

    @Injected(\.appData) var appData

    private var repository = Container.shared.taskRepository()

    @MainActor

    func loadTask(with weekDays:[String]) async throws -> TaskRequest {
        let result =  try await repository.loadTaskRegister(with: weekDays, childrenID: appData.childrenId, token: appData.token)
        print(result)
        return result
    }

    
}
