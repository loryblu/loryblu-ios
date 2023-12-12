import SwiftUI

struct LocbookNavigationStack: View {
    typealias NavigationCoordinator = LocbookNavigationCoordinator
    
    @ObservedObject var coordinator: NavigationCoordinator
    @EnvironmentObject var appData: AppData
    
    init() {
        coordinator = .init()
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildView(
                page: .register(
                    .init(onNewTask: { gotoLocbookActions() })
                )
            )
            .navigationDestination(for: NavigationCoordinator.Destination.Navigation.self) { destination in
                coordinator.buildView(page: destination)
                    .environmentObject(coordinator)
            }
        }
    }
    
    private func gotoLocbookActions() {
        
    }
}

struct LocbookNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        LocbookNavigationStack()
            .environmentObject(AppData())
    }
}
