import Foundation

class NewPasswordModel: ObservableObject {
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isEqual: Bool = true
    @Published var goToLogin: Bool = false
    var service = RepositorySetPassword(network: Network.shared)

    func setPassword(newPassword: String, token: String) async {
        var result = await service.setPassword(password: newPassword, token: token)
        if result.message == "Senha redefinida com sucesso!" {
            goToLogin.toggle()
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
