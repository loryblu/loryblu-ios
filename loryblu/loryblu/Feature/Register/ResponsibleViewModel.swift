import Foundation

class ResponsibleViewModel: ObservableObject {

    enum FocusedField: Equatable {
        case none, name, email, password, confirmPassword
    }

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var textError: String = ""
    @Published var hasError: Bool = false
    @Published var errorField: FocusedField = .none

    func showError() {
        if !ValidateRules.validateName(name) {
            hasError = true
            textError = LBStrings.Register.errorName
            errorField = .name
        } else if !ValidateRules.validate(email: email) {
            hasError = true
            textError = LBStrings.Register.errorEmail
            errorField = .email
        } else if confirmPassword != password {
            hasError = true
            textError = LBStrings.Register.errorPassord
            errorField = .confirmPassword
        } else {
            clearError()
        }
    }

    func clearError() {
        hasError = false
        textError = ""
        errorField = .none
    }

}
