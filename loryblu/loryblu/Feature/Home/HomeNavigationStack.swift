import SwiftUI

struct HomeNavigationStack: View {
    typealias NavigationCoordinator = HomeNavigationCoordinator

    @ObservedObject var coordinator: NavigationCoordinator
    @EnvironmentObject var appData: AppData

    init() {
        coordinator = .init()
    }

    var body: some View {
        NavigationStack {
            coordinator.buildView(cover: .home)
                .fullScreenCover(item: $coordinator.fullScreen) { destination in
                    coordinator.buildView(cover: destination)
                }
                .sheet(item: $coordinator.sheet) { destination in
                    coordinator.buildView(sheet: destination)
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
