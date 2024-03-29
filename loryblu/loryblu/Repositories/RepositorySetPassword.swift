import Factory
import Foundation

class RepositorySetPassword {
    private let network: Network

    init(network: Network) {
        self.network = network
    }

    func setPassword(password: String, token: String) async -> ResponseMessage {
        var data = ResponseMessage()
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(
                        baseURL: Server.baseURL,
                        path: Endpoint.defineNewPassword,
                        method: .put,
                        header: header,
                        body: JSONParser.parseData(
                            from: ["password": "\(password)", "recoveryToken": "\(token)"])
                    )
        do {
            data = try await network.request(request: request, returning: ResponseMessage.self)
            return data
        } catch {
            return data
        }
    }

    func recoveryPassword(with email: String) async -> Bool {
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(
                        baseURL: Server.baseURL,
                        path: Endpoint.passwordRecovery,
                        method: .post,
                        header: header,
                        body: JSONParser.parseData(from: ["email": "\(email)"])
                    )

        do {
            _ = try await network.request(request: request, returning: ResponseMessage.self)
            return true
        } catch {
            return false
        }
    }
}
