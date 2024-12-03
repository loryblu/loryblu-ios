import SwiftUI

@MainActor
class MenuNavigationCoordinator: ObservableObject {
    
    enum Destination {
        enum Navigation: Hashable {
            case menu(MenuView.Props)
            case childProfile(ChildProfileView.Props)
        }
    }

    @Published var path: [Destination.Navigation]

    init() {
        path = []
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }

    func popView(count: Int = 1) {
        if path.isEmpty == false {
            path.removeLast(count)
        }
    }

    func pushChildProfileView(props: ChildProfileView.Props) {
        navigate(to: .childProfile(props))
    }

    @ViewBuilder
    func buildView(sheet destination: Destination.Navigation) -> some View {
        switch destination {
        case let .menu(props):
            MenuView(props: props)
        case let .childProfile(props):
            ChildProfileView(props: props)
        }
    }

    private func navigate(to destination: Destination.Navigation) {
        self.path.append(destination)
    }
}
