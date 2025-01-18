import Factory
import Foundation

class HomeViewModel: ObservableObject {
    let userData = Container.shared.appData().userData?.data.user

    var childName: String {
        firstName(fulName: userData?.childrens.first?.fullname ?? String())
    }

    func firstName(fulName: String) -> String {
        var childrenName: String = String()
        let arrayName = fulName.components(separatedBy: " ")

        guard let firstName = arrayName.first else {
            return childrenName
        }
        childrenName = firstName
        return childrenName
    }
}

extension Container {
    var homeViewModel: Factory<HomeViewModel> {
        self {
            HomeViewModel()
        }
    }
}
