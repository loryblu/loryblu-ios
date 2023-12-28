import Factory
import Foundation

class LoginModel: ObservableObject {
    enum LoginStatus {
        case none
        case success
        case fail
    }

    private var repository = Container.shared.autenticationRepository()

    @MainActor
    func authenticate(email: String, password: String) {
        Task {
            do {
                let result = try await repository.login(email: email, password: password)
                Container.shared.appData().setLoginStatusLogged()
                print(result)
            } catch {
                print("Deu errado!")
            }
        }
    }

}
