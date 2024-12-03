import Foundation

class ChildProfileViewModel : ObservableObject {
    @Published var childName: String = "Rodrigo"
    @Published var childGender: LBGenderButton.Gender?
    @Published var childBirth: Date?
}
