import Factory
import Foundation

class HomeViewModel: ObservableObject {
    let userData = Container.shared.appData().userData?.data.user
    
    var childName: String {
        userData?.childrens.first?.fullname ?? ""
    }
}

extension Container {
    var homeViewModel: Factory<HomeViewModel> {
        self {
            HomeViewModel()
        }
    }
}
