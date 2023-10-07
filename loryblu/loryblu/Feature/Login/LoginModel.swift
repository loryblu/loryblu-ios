import Foundation

class LoginModel: ObservableObject {
    enum LoginStatus {
        case none
        case success
        case fail
    }

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var status: LoginStatus = .none

    private var repository = AuthenticationRepository()

    @MainActor
    func authenticate() {
        status = .none

        Task {
            do {
                let result = try await repository.login(email: email, password: password)
                status = .success
                print("Foi ... deu certo o login")
            } catch {
                status = .fail
                print("Deu errado!")
            }
        }
    }

}
