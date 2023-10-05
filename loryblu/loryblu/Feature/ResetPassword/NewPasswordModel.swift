import Foundation

class NewPasswordModel: ObservableObject {
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isEqual: Bool = true
    var service = RepositorySetPassword(network: Network.shared)

    func setPassword(newPassword: String, token: String) async {
        let result = await service.setPassword(password: newPassword, token: token)
    }

    func showError() {
        if password == confirmPassword {
            isEqual = true
        } else {
            isEqual = false
        }
    }
}
