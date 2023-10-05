import Foundation

class RegisterChildViewModel: ObservableObject {
    enum FocusedField: Equatable {
        case none, nameChild, birthDay, gender
    }
    @Published var nameChild: String = ""
    @Published var birthDay: String = ""
    @Published var gender: LBGenderButton.Gender?
    @Published var agreePrivacy: Bool = false
    @Published var textError: String = ""
    @Published var hasError: Bool = false
    @Published var errorField: FocusedField = .none
    private(set) var user: UserRegister
    //var service = Service()

    init(user: UserRegister) {
        self.user = user
    }

    func showError() {
        if !ValidateRules.validateName(nameChild) {
            hasError = true
            textError = LBStrings.Register.errorName
            errorField = .nameChild
        } else if birthDay.isEmpty {
            hasError = true
            textError = LBStrings.Register.errorBirthDay
            errorField = .birthDay
        } else if gender == nil {
            hasError = true
            textError = LBStrings.Register.errorGender
            errorField = .gender
        } else {
            clearError()
        }
    }

    func clearError() {
        hasError = false
        textError = ""
        errorField = .none
    }

    func saveRegister() {
        user.nameChild = nameChild
        user.dateBirth = birthDay
        user.agreePrivacy = agreePrivacy
        if gender == .male {
            user.gender = .male
        } else if gender == .female {
            user.gender = .female
        }

        print(user)
    }

    func validadeData() -> Bool {
        ValidateRules.validateName(nameChild) && birthDay != nil && agreePrivacy
    }
}
