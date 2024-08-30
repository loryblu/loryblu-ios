import Factory
import Foundation

class LoginModel: ObservableObject {
    enum LoginStatus {
        case none
        case success
        case fail
    }

    @Published var loginStatus: LoginStatus = .none
    @Published var networkErro: String = ""

    private var repository = Container.shared.autenticationRepository()

    @MainActor
    func authenticate(email: String, password: String) {
        loginStatus = .none
        Task {
            do {
                let result = try await repository.login(email: email, password: password)
                Container.shared.appData().setLoginStatusLogged(user: result)
                print(result)
            } catch {
                print("Deu errado!")
            }
        }
    }

}
