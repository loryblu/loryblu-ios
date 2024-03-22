import Factory
import Foundation

class LoginModel: ObservableObject {
    enum LoginStatus {
        case none
        case success
        case fail
    }
    @Published var loginStatus: LoginStatus = .none
    @Published var networkError: String = ""
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
                let networkError = error as NSError
                print(networkError)
                switch networkError.code {
                case 401:
                    self.networkError = LBStrings.Login.userNotFound
                case 422:
                    self.networkError = LBStrings.Login.emailNotFound
                case 500...:
                    self.networkError = LBStrings.Login.serverError
                default :
                    self.networkError = LBStrings.Login.serverError
                }
                loginStatus = .fail
            }
        }
    }

}
