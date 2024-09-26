import SwiftUI
import Factory

@MainActor
class HomeNavigationCoordinator: ObservableObject {

    @EnvironmentObject var appData: AppData
    let userData = Container.shared.appData().userData?.data.user

    enum Destination {
        enum FullScreenPage: String, Identifiable {
            case home
            case locbook

            var id: String {
                self.rawValue
            }
        }

        enum Sheet: String, Identifiable {
            case menu

            var id: String {
                self.rawValue
            }
        }
    }

    // MARK: - Internal Properties

    @Published var fullScreen: Destination.FullScreenPage?
    @Published var sheet: Destination.Sheet?

    // MARK: - Initializers

    init() {
        fullScreen = nil
        sheet = nil
    }

    // MARK: - Internal Methods

    func popToRoot() {
        fullScreen = nil
        sheet = nil
    }

    @ViewBuilder
    func buildView(cover destination: Destination.FullScreenPage) -> some View {
        switch destination {
        case .home:
            HomeView(
                props: .init (
                    onSelectCard: { self.fullScreen = .locbook },
                    onShowMenu: { self.sheet = .menu }
                )
            )
        case .locbook:
            LocbookNavigationStack(
                props: LocbookNavigationStack.Props(
                    onFinish: { self.fullScreen = nil },
                    onDismiss: { self.fullScreen = nil }
                )
            )
        }
    }

    @ViewBuilder
    func buildView(sheet destination: Destination.Sheet) -> some View {
        switch destination {
        case .menu:
            MenuView(user: userData! )
                .environmentObject(AppData())
        }
    }
}
