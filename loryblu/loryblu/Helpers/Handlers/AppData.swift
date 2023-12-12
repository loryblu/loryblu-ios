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
    
    func updateLoginState() {
        Task { @MainActor in
            loginStatus = .logged
        }
    }
}
