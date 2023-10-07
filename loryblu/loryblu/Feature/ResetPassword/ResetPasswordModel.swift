import Foundation
import SwiftUI

enum FechtEmail {
    case success
    case error
    case idle
}

class ResetPasswordModel: ObservableObject {
    @Published var fecht: FechtEmail = .idle
    var service = RepositorySetPassword(network: Network.shared)

    func recoveryPassowrd(with email: String) async {
        let isValid = await service.recoveryPassword(with: email)
        switch isValid {
        case true :
            self.fecht = .success
        case false:
            self.fecht = .error
        }
    }
}
