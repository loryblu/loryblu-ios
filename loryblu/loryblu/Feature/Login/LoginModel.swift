import Factory
import Foundation

class LoginModel: ObservableObject {
    enum LoginStatus {
        case none
        case success
        case fail
    }

    @Published var email: String = ""
    @Published var password: String = ""

    private var repository = AuthenticationRepository()

    @MainActor
    func authenticate() {
        Task {
            do {
                let result = try await repository.login(email: email, password: password)
                Container.shared.appData().setLoginStatusLogged()
            } catch {
                print("Deu errado!")
            }
        }
    }

}
