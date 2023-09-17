import Foundation

class RegisterChildViewModel: ObservableObject {
    @Published var nameChild: String = ""
    @Published var birthDay: String = ""
    @Published var gender: LBGenderButton.Gender?
    private(set) var user: Register

    init(user: Register) {
        self.user = user
    }

    func saveRegister() {
        user.nameChild = nameChild
        user.dateBirth = birthDay
        if gender == .male {
            user.gender = .male
        } else if gender == .female {
            user.gender = .female
        }
    }
}
