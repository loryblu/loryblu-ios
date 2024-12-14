import Factory
import Foundation

class RegisterResponsibleViewModel: ObservableObject {

    enum FocusedField: Equatable {
        case none, name, email, password, confirmPassword
    }

    @Published var name: String = String()
    @Published var email: String = String()
    @Published var password: String = String()
    @Published var confirmPassword: String = String()
    @Published var textError: String = String()
    @Published var hasError: Bool = false
    @Published var errorField: FocusedField = .none

    var user = UserRegister()

    func makeRegisterChildViewModel() -> RegisterChildViewModel {
        saveRegister()
        return RegisterChildViewModel(user: user, container: Container.shared)
    }

    func showError() {
        if !ValidateRules.validateName(name) {
            hasError = true
            textError = LBStrings.Register.errorName
            errorField = .name
        } else if !ValidateRules.validate(email: email) {
            hasError = true
            textError = LBStrings.Register.errorEmail
            errorField = .email
        } else if !ValidateRules.validateSize(password: password) {
            hasError = true
            errorField = .password
        } else if confirmPassword != password {
            hasError = true
            textError = LBStrings.Register.errorPassword
            errorField = .confirmPassword
        } else {
            clearError()
        }
    }

    func clearError() {
        hasError = false
        textError = String()
        errorField = .none
    }

    func showNextScreen() -> Bool {
        if ValidateRules.validate(email: email) && ValidateRules.validateName(name) && validatePassword() {
            return true
        } else {
            return false
        }
    }

    func saveRegister() {
        user.name = name
        user.email = email
        user.password = password
    }

    private func validatePassword() -> Bool {
        confirmPassword == password && ValidateRules.validatePassword(password: password)
    }
}
