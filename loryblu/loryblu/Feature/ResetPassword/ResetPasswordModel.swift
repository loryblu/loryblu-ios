import Foundation
import SwiftUI

class ResetPasswordModel: ObservableObject {
    @Published var fecht: FechtEmail = .idle
    var service = RecoveryService(network: Network.shared)

    func login(email: String) {
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
