import Foundation
import SwiftUI

enum FechtEmail {
    case success
    case error
    case idle
}

class ResetPasswordModel: ObservableObject {
    @Published var fecht: FechtEmail = .idle
    var service = RecoveryService(network: Network.shared)

    func recoveryPassowrd(with email: String) {
        service.recoveryPassword(with: email) { isValid in
            DispatchQueue.main.async {
                print("retorno \(isValid)")
                switch isValid {
                case true :
                    self.fecht = .success
                case false:
                    self.fecht = .error
                }
            }
        }
    }
}
