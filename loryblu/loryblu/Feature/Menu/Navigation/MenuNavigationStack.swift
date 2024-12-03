import SwiftUI

struct MenuNavigationStack: View {

    typealias NavigationCoordinator = MenuNavigationCoordinator

    struct Props {
        let userData: User?
        let onFinish: ClosureType.VoidVoid?
        let onDismiss: ClosureType.VoidVoid?
    }

    @ObservedObject var coordinator: NavigationCoordinator
    @Environment(\.dismiss) private var dismiss

    private let props: Props

    init(props: Props) {
        coordinator = .init()
        self.props = props
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildView(
                sheet: .menu(.init(user: props.userData, onChildProfile: {
                    coordinator.pushChildProfileView(
                        props: ChildProfileView.Props(
                            title: "Perfil da criança",
                            childName: props.userData?.childrens[0].fullname ?? "",
                            childBirth: props.userData?.childrens[0].birthdate ?? "",
                            childGender: props.userData?.childrens[0].gender ?? "",
                            editionBlocked: false,
                            onClose: { dismiss() }
                        )
                    )
                }))
            )
            .navigationDestination(for: NavigationCoordinator.Destination.Navigation.self) { destination in
                coordinator.buildView(sheet: destination)
                    .environmentObject(coordinator)
            }
        }
    }
}
