import UIKit

final class SessionManager {
    static let shared = SessionManager()

    enum Keys: String {
        case userName = "keyUserName"
        case dateOfBirth =  "dateOfBirth"
        case photo = "keyPhoto"
        case useCoins = "useCoins"
        case email = "email"
    }

    var userName: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.userName.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.userName.rawValue)
        }
    }

    var dateOfBirth: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.dateOfBirth.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.dateOfBirth.rawValue)
        }
    }

    var photo: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.photo.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.photo.rawValue)
        }
    }

    var useCoins: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.useCoins.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.useCoins.rawValue)
        }
    }

    var email: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.email.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.email.rawValue)
        }
    }

    var hasSession: Bool {
        userName != nil
    }

    func startSession(_ userModel: User) {
        userName = userModel.name
        dateOfBirth = userModel.dateOfBirth
        photo = userModel.photo
        useCoins = String(userModel.useCoins)
        email = userModel.email
    }

    func finishSession() {
        userName = nil
        dateOfBirth = nil
        photo = nil
        useCoins = nil
        email = nil
        goToSignIn()
    }

    private func goToSignIn() {
        userName = nil
        dateOfBirth = nil
        photo = nil
        useCoins = nil
        email = nil
        (UIApplication.shared.delegate as? AppDelegate)?.logout()
    }

}
