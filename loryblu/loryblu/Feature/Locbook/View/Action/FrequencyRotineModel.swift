import Foundation
import Factory

class FrequencyRotineModel: ObservableObject {
    enum StatusTask {
        case none
        case success
        case fail
    }

    @Published var stateTask: StatusTask = .none

    private var repository = Container.shared.taskRepository()

    @MainActor
    func saveTask(task: LocbookTask) {
        Task {
            do {
                let result = try await repository.taskRegister(with: task)
                stateTask = .success
            } catch {
                stateTask = .fail
                print("deu ruim")
            }
        }
    }
}