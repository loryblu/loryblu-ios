import SwiftUI

@MainActor
class HomeNavigationCoordinator: ObservableObject {
    
    @EnvironmentObject var appData: AppData
    
    enum Destination {
        enum Navigation: String, Identifiable  {
            case locbook
            
            var id: String {
                self.rawValue
            }
        }
        
        enum FullScreenPage: String, Identifiable {
            case home
            
            var id: String {
                self.rawValue
            }
        }
    }
    
    // MARK: - Internal Properties
    
    @Published var path: [Destination.Navigation]
    @Published var fullScreen: Destination.FullScreenPage?
    
    // MARK: - Initializers
    
    init() {
        path = []
        fullScreen = nil
    }
        
    // MARK: - Internal Methods
        
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func popView() {
        if path.isEmpty == false {
            path.removeLast()
        }
    }
    
    @ViewBuilder
    func buildView(page destination: Destination.Navigation) -> some View {
        switch destination {
        case .locbook:
            LocbookTasksView()
        }
    }

    @ViewBuilder
    func buildView(cover destination: Destination.FullScreenPage) -> some View {
        switch destination {
        case .home:
            HomeView()
        }
    }

    // MARK: - Private Methods

    private func navigate(to destination: Destination.Navigation) {
        self.path.append(destination)
    }

}
