import Foundation

class RegisterChildViewModel: ObservableObject {
    enum FocusedField: Equatable {
        case none, nameChild, birthDay, gender
    }

    @Published var nameChild: String = ""
    @Published var gender: LBGenderButton.Gender?
    @Published var agreePrivacy: Bool = false
    @Published var textError: String = ""
    @Published var hasError: Bool = false
    @Published var errorField: FocusedField = .none
    @Published var registerSuccess: Bool = false
    @Published var birthDate: Date?

    private(set) var user: UserRegister

    var isValid: Bool {
        ValidateRules.validateName(nameChild) && birthDate != nil && agreePrivacy
    }

    private var repository = RegisterRepository()


    init(user: UserRegister) {
        self.user = user
    }

    func showError() {
        if !ValidateRules.validateName(nameChild) {
            hasError = true
            textError = LBStrings.Register.errorName
            errorField = .nameChild
        } else if birthDate == nil {
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
        guard let birthDate = birthDate, let gender = gender else {
            showError()
            return
        }

        user.nameChild = nameChild
        user.dateBirth = Formatter.yearMonthDay.string(from: birthDate)
        user.agreePrivacy = agreePrivacy
        user.gender = gender == .male ? .male : .female

        Task {
            do {
                let result = try await repository.register(user: user)
                registerSuccess = true
                NSLog("Foi")
            } catch {
                print(error.localizedDescription)
            }
        }

        print(user)
    }
}
