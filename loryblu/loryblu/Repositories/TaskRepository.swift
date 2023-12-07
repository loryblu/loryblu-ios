import Foundation

class TaskRepository {

    let network: Network

    init(network: Network = Network.shared) {
        self.network = network
    }

    func taskRegister(with locBookTask: LocbookTask) async -> Bool {
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(
                        baseURL: Server.baseURL,
                        path: Endpoint.passwordRecovery,
                        method: .post,
                        header: header,
                        body: JSONParser.parseData(from: ["childrenId": "\(locBookTask.)"])
                    )

        do {
            _ = try await network.request(request: request, returning: ResponseMessage.self)
            return true
        } catch {
            return false
        }
    }
}
