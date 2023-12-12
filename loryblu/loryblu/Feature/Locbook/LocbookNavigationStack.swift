import SwiftUI

struct LocbookNavigationStack: View {
    typealias NavigationCoordinator = LocbookNavigationCoordinator
    
    struct Props {
        let onFinish: ClosureType.VoidVoid?
        let onDismiss: ClosureType.VoidVoid?
    }
    
    @ObservedObject var coordinator: NavigationCoordinator
    
    private let props: Props
    
    init(props: Props) {
        coordinator = .init()
        self.props = props
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildView(
                page: .register(
                    .init(onNewTask: { pushLocbookActions() })
                )
            )
            .navigationDestination(for: NavigationCoordinator.Destination.Navigation.self) { destination in
                coordinator.buildView(page: destination)
                    .environmentObject(coordinator)
            }
        }
    }
    
    private func pushLocbookActions() {
        coordinator.pushActionsView()
    }
}

struct LocbookNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        LocbookNavigationStack(props: .init(onFinish: nil, onDismiss: nil))
            .environmentObject(AppData())
    }
}
