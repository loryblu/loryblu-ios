import Foundation

enum RequestState {
    case success
    case failure
}

class NewPasswordModel: ObservableObject {
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isEqual: Bool = true
    @Published var goToLogin: Bool = false
    @Published var state: RequestState = .failure
    var service = RepositorySetPassword(network: Network.shared)

    func setPassword(newPassword: String, token: String) async {
        let result = await service.setPassword(password: newPassword, token: token)
        //let result = RecoveryData(message: "Senha redefinida com sucesso!") // para teste da view
        await MainActor.run {
            if result.message == "Senha redefinida com sucesso!" {
                state = .success
            } else {
                state = .failure
            }
            goToLogin = true
        }
    }

    func showError() {
        if password == confirmPassword {
            isEqual = true
        } else {
            isEqual = false
        }
    }
}
