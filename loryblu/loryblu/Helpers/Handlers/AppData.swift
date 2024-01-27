import Foundation

class AppData: ObservableObject {
    enum LoginStatus {
        case loading
        case logged
        case notLogged
    }

    @Published var isTokenReceived: Bool = false
    @Published var token: String = ""
    @Published var loginStatus: LoginStatus = .notLogged
    @Published var userData: UserAuth?

    func setLoginStatusLogged(user: UserAuth) {
        Task { @MainActor in
            loginStatus = .logged
            userData = user
        }
    }
}
