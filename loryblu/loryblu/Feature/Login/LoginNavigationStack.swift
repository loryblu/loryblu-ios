import SwiftUI

struct LoginNavigationStack: View {
    typealias NavigationCoordinator = LoginNavigationCoordinator
    
    @ObservedObject var coordinator: NavigationCoordinator
    @EnvironmentObject var appData: AppData
    
    init() {
        coordinator = .init()
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildView(cover: .login)
                .navigationDestination(for: NavigationCoordinator.Destination.Navigation.self) { destination in
                    coordinator.buildView(page: destination)
                        .environmentObject(coordinator)
                }
                .fullScreenCover(item: $coordinator.fullScreen) { destination in
                    coordinator.buildView(cover: destination)
                }
                .onReceive(appData.$loginStatus) { status in
                    if status == .logged {
                        coordinator.showHome()
                    }
                }
        }
    }
}

struct LoginNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        LoginNavigationStack()
            .environmentObject(AppData())
    }
}
