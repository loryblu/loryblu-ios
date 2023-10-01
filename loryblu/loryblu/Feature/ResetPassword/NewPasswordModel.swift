import Foundation

class NewPasswordModel: ObservableObject {
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isEqual: Bool = true
    var service = SetPasswordService(network: Network.shared)

    func setPassword(setPassword: SetPassword) {

        service.setPassword(password: setPassword.password, token: setPassword.recoveryToken) { success in
            DispatchQueue.main.async {
                print("retorno \(success)")

            }
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
