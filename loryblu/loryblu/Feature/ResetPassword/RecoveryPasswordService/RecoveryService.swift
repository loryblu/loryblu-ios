import Foundation

struct RecoveryData: Codable {
    var message: String?
}

class RecoveryService {
    private let network: Network

    init(network: Network) {
        self.network = network
    }

    func recoveryPassword(with email: String, onComplete: @escaping(Bool) -> Void) {
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(baseURL: Server.baseURL,
                                   path: Server.recoveryPasswordURL,
                                   method: .post,
                                   header: header,
                                   body: ["email": "\(email)"])

            network.request(request: request, returning: RecoveryData.self) { result  in
                switch result {
                case .failure(let error):
                    print(error)
                    onComplete(false)
                case .success(let message):
                    guard let message = message else {
                        return
                    }
                    print(message)
                    onComplete(true)
                }
            }
    }
}
