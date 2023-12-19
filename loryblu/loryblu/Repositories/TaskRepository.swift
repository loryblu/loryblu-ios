import Foundation

class TaskRepository {

    let network: Network

    init(network: Network) {
        self.network = network
    }

    func taskRegister(with locBookTask: LocbookTask) async -> Bool {
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(
                        baseURL: Server.baseURL,
                        path: Endpoint.task,
                        method: .post,
                        header: header,
                        body: JSONParser.parseData(from: ["childrenId": "\(String(describing: locBookTask.childrenId))",
                                                          "categoryId": "\(String(describing: locBookTask.categoryId))",
                                                          "shif": "\(String(describing: locBookTask.shift))",
                                                          "frequency": ["\(String(describing: locBookTask.frequency))"],
                                                          "order": "\(String(describing: locBookTask.order))"
                                                         ])
                    )

        do {
            _ = try await network.request(request: request, returning: ResponseMessage.self)
            return true
        } catch {
            return false
        }
    }
}
