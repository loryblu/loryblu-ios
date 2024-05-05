import Foundation
import Factory
class TaskRepository {
    let network: Network
    let token = Container.shared.appData

    init(network: Network) {
        self.network = network
    }

    func taskRegister(with locBookTask: LocbookTask, token: String, childrenID: Int) async -> Bool {
        guard let categoryId = locBookTask.categoryId?.description else {
            return false
        }

        guard let shift = locBookTask.shift else {
            return false
        }

        guard let frequency = locBookTask.frequency else {
            return false
        }

        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: Endpoint.task)
            .with(method: .post)
            .with(body: JSONParser.parseData(from: [
                "childrenId": childrenID,
                "categoryId": categoryId,
                "shift": "\(shift)",
                "frequency": frequency.map { $0.rawValue },
                "order": 0
            ]))
            .with(addHeaderName: "Authorization", value: "Bearer \(token)")
            .with(addHeaderName: "User-Agent", value: "LoryBlu(iOS)")
            .with(addHeaderName: "Content-Type", value: "application/json")
            .build()

        do {
            _ = try await network.request(request: request, returning: ResponseMessage.self)
            return true
        } catch {
            return false
        }
    }

    func taskEdit(with locBookTask: LocbookTask, token: String, childrenID: Int) async -> Bool {
        guard let categoryId = locBookTask.categoryId,
              let shift = locBookTask.shift,
              let frequency = locBookTask.frequency,
              let taskId = locBookTask.id
        else {
            return false
        }

        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: Endpoint.task + "?id_task=\(taskId)")
            .with(method: .patch)
            .with(body: JSONParser.parseData(from: [
                "childrenId": childrenID,
                "categoryId": categoryId,
                "shift": "\(shift)",
                "frequency": frequency.map { $0.rawValue },
                "order": 0
            ]))
            .with(addHeaderName: "Authorization", value: "Bearer \(token)")
            .with(addHeaderName: "User-Agent", value: "LoryBlu(iOS)")
            .with(addHeaderName: "Content-Type", value: "application/json")
            .build()

        do {
            _ = try await network.request(request: request, returning: ResponseMessage.self)
            return true
        } catch {
            return false
        }
    }

    func fetchTasks(token: String, childrenId: Int) async -> [TaskModel] {
        var tasks: [TaskModel] = []
        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: "\(Endpoint.task)?childrenId=\(childrenId)&frequency=sun,mon,tue,wed,thu,fri,sat")
            .with(method: .get)
            .with(addHeaderName: "Authorization", value: "Bearer \(token)")
            .build()

        do {
            let result = try await network.request(request: request, returning: ResponseData<NetworkDataModel>.self)
            tasks = getTasks(type: LBStrings.Locbook.titleStudy, tasks: result.data?.study ?? [])
            tasks += getTasks(type: LBStrings.Locbook.titleRotine, tasks: result.data?.routine ?? [])
            return tasks
        } catch {
            return tasks
        }
    }
}

extension TaskRepository {
    func getTasks(type: String, tasks: [TasksNetworkModel]) -> [TaskModel] {
        return tasks.toTasksModel(category: type)
    }
}
