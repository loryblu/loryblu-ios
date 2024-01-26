import Factory
import Foundation
import SwiftUI

@MainActor
class ResetPasswordModel: ObservableObject {
    enum FechtEmail {
        case success
        case error
        case idle
    }
    
    @Published var fecht: FechtEmail = .idle
    var service: RepositorySetPassword
    
    init(fecht: FechtEmail = .idle, container: Container) {
        self.fecht = fecht
        self.service = container.setPasswordRepository()
    }

    func recoveryPassowrd(with email: String) async {
        let isValid = await service.recoveryPassword(with: email)
        switch isValid {
        case true:
            self.fecht = .success
        case false:
            self.fecht = .error
        }
    }
}
