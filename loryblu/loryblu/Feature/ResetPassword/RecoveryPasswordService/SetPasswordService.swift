import Foundation

class SetPasswordService {

    private let network: Network

    init(network: Network) {
        self.network = network
    }

    func setPassword(password: String, token: String, onComplete: @escaping(Bool) -> Void) {
        let header: [String: String] = ["Content-Type": "application/json"]
        let request = RequestModel(baseURL: Server.baseURL,
                                   path: Server.setPasswordURL,
                                   method: .put,
                                   header: header,
                                   body: ["email": "\(password)", "recoveryToken": "\(token)"])

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
