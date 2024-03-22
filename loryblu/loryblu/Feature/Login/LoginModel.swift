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
                Container.shared.appData().setLoginStatusLogged(user: result)
                print(result)
            } catch {
                let networkError = error as NSError
                switch networkError.code {
                case 401:
                    print("Senha ou úsuário incorreto")
                case 422:
                    print("o email informado não possui cadastro")
                default :
                    print("Erro no servidor tente novamente mais tarde")
                }
                print("***********",networkError)

                // Mark: 401 Unauthorized credênciais invalidas password
                // 422 Unprocessable Entity O email informado não foi cadastrado
            }
        }
    }

}
