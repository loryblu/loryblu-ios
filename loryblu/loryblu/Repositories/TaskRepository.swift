import Foundation
import Factory

class TaskRepository {

    let network: Network

    init(network: Network) {
        self.network = network
    }

    var token = Container.shared.appData

    func taskRegister(with locBookTask: LocbookTask, token: String, childrenID: String) async -> Bool {

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
}
