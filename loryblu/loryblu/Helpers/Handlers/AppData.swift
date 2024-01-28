import Foundation

class AppData: ObservableObject {
    enum LoginStatus {
        case loading
        case logged
        case notLogged
    }

    @Published var isTokenReceived: Bool = false
    @Published var token: String = ""
    @Published var userData: UserAuth?
    
    var loginStatus: LoginStatus {
        guard userData != nil else {
            return .notLogged
        }

        return .logged
    }

    func setLoginStatusLogged(user: UserAuth) {
        Task { @MainActor in
            userData = user
        }
    }
}
