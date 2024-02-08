import Foundation
import Factory

class FrequencyRotineModel: ObservableObject {
    enum StatusTask {
        case none
        case success
        case fail
    }

    @Published var stateTask: StatusTask = .none
    @Injected(\.appData) var appData

    private var repository = Container.shared.taskRepository()

    @MainActor
    func saveTask(task: LocbookTask) async {

//        Task {
//            do {
                let result = try await repository.taskRegister(with: task,
                                                               token: appData.token,
                                                               childrenID: appData.childrenId)
                if result {
                    print("request success")
                    stateTask = .success
                } else {
                    print("request fail")
                    stateTask = .fail
                }
//            }
//        }
    }
}
