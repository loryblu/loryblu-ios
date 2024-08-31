import Factory
import Foundation

class LoginModel: ObservableObject {
    enum LoginStatus {
        case none
        case processing
        case success
        case fail
    }

    @Published var loginStatus: LoginStatus = .none
    @Published var networkError: String = ""

    private var repository = Container.shared.autenticationRepository()

    @MainActor
    func authenticate(email: String, password: String) {
        loginStatus = .processing
        Task {
            do {
                let result = try await repository.login(email: email, password: password)
                Container.shared.appData().setLoginStatusLogged(user: result)
                loginStatus = .success
             } catch {
                let networkError = error as NSError
                 switch networkError.code {
                 case 401:
                     self.networkError = LBStrings.Login.userNotFound
                 case 422:
                     self.networkError = LBStrings.Login.userNotFound
                 default:
                     self.networkError = LBStrings.Login.serverError
                 }
                 loginStatus = .fail
            }
        }
    }

}
