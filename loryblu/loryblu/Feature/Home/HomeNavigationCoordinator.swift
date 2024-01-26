import SwiftUI

@MainActor
class HomeNavigationCoordinator: ObservableObject {
    
    @EnvironmentObject var appData: AppData
    
    enum Destination {
        enum FullScreenPage: String, Identifiable {
            case home
            case locbook
            
            var id: String {
                self.rawValue
            }
        }
    }
    
    // MARK: - Internal Properties
    
    @Published var fullScreen: Destination.FullScreenPage?
    
    // MARK: - Initializers
    
    init() {
        fullScreen = nil
    }
        
    // MARK: - Internal Methods
        
    func popToRoot() {
        fullScreen = nil
    }

    @ViewBuilder
    func buildView(cover destination: Destination.FullScreenPage) -> some View {
        switch destination {
        case .home:
            HomeView(
                props: .init (
                    onSelectCard: { self.fullScreen = .locbook }
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
}
