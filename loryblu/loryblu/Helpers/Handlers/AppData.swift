import Foundation

class AppData: ObservableObject {
    enum LoginStatus {
        case loading, logged, notLogged
    }

    @Published var isTokenReceived: Bool = false
    @Published var token: String = ""
    @Published var childrenId: Int = 0
    @Published var userData: UserAuth?

    @Published var loginStatus: LoginStatus = .notLogged

    func setLoginStatusLogged(user: UserAuth) {
        Task { @MainActor in
            userData = user
            if userData != nil {
                loginStatus = .logged
            }
            token = user.data.accessToken

            if let id = user.data.user.childrens.first?.id {
                childrenId = id
            }
        }
    }

    func logout() {
        userData = nil
        loginStatus = .notLogged
    }
}
