import Foundation

struct RecoveryData: Codable {
    var message: String?
}

class RepositorySetPassword {
    private let network: Network

    init(network: Network) {
        self.network = network
    }

    func setPassword(password: String, token: String) async -> RecoveryData {
        var data = RecoveryData()
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(baseURL: Server.baseURL,
                                   path: Server.setPasswordURL,
                                   method: .put,
                                   header: header,
                                   body: ["password": "\(password)", "recoveryToken": "\(token)"])
        do {
            data = try await network.request(request: request, returning: RecoveryData.self)
            return data
        } catch {
            return data
        }
    }

    func recoveryPassword(with email: String) async -> Bool {
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(baseURL: Server.baseURL,
                                   path: Server.recoveryPasswordURL,
                                   method: .post,
                                   header: header,
                                   body: ["email": "\(email)"])

        do {
            _ = try await network.request(request: request, returning: RecoveryData.self)
            return true
        } catch {
            return false
        }
    }
}
