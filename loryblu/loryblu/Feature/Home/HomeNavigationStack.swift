import SwiftUI

struct HomeNavigationStack: View {
    typealias NavigationCoordinator = HomeNavigationCoordinator
    
    @ObservedObject var coordinator: NavigationCoordinator
    @EnvironmentObject var appData: AppData
    
    init() {
        coordinator = .init()
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildView(cover: .home)
                .navigationDestination(for: NavigationCoordinator.Destination.Navigation.self) { destination in
                    coordinator.buildView(page: destination)
                        .environmentObject(coordinator)
                }
                .fullScreenCover(item: $coordinator.fullScreen) { destination in
                    coordinator.buildView(cover: destination)
                }
        }
    }
}

struct HomeNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationStack()
            .environmentObject(AppData())
    }
}
