import Factory
import Foundation

enum RequestState {
    case success
    case failure
}

@MainActor
class NewPasswordModel: ObservableObject {
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isEqual: Bool = true
    @Published var goToLogin: Bool = false
    @Published var state: RequestState = .failure
    
    private let service: RepositorySetPassword
    
    init(container: Container = .shared) {
        service = container.setPasswordRepository()
    }

    func setPassword(newPassword: String, token: String) async {
        let result = await service.setPassword(password: newPassword, token: token)
        if result.message == "Senha redefinida com sucesso!" {
            state = .success
        } else {
            state = .failure
        }
        goToLogin.toggle()
    }

    func showError() {
        if password == confirmPassword {
            isEqual = true
        } else {
            isEqual = false
        }
    }
}
