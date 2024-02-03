import Foundation
import Factory

class TaskRepository {

    let network: Network

    init(network: Network) {
        self.network = network
    }
    var token = Container.shared.appData
    func taskRegister(with locBookTask: LocbookTask, token: String , childrenID: Int) async -> ResponseMessage {
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(
                        bearer: ["Bear \(token)" : "Authorization"],
                        baseURL: Server.baseURL,
                        path: Endpoint.task,
                        method: .post,
                        header: header,
                        body: JSONParser.parseData(
                            from: [
                            "childrenId": "\(String(describing: locBookTask.childrenId))",
                            "categoryId": "\(String(describing: locBookTask.categoryId))",
                            "shif": "\(String(describing: locBookTask.shift))",
                            "frequency": ["\(String(describing: locBookTask.frequency))"],
                            "order": "\(String(describing: locBookTask.order))"
                            ])
                    )

        do {
            let response = try await network.request(request: request, returning: ResponseMessage.self)
            return response
        } catch {
            return ResponseMessage.init()
        }
    }
}
