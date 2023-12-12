import SwiftUI

@MainActor
class LocbookNavigationCoordinator: ObservableObject {
        
    enum Destination {
        enum Navigation: Hashable {            
            case register(LocbookRegisterView.Props)
            case actions
        }
    }
    
    // MARK: - Internal Properties
    
    @Published var path: [Destination.Navigation]
    
    // MARK: - Initializers
    
    init() {
        path = []
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
    
    func pushActionsView() {
        navigate(to: .actions)
    }
    
    @ViewBuilder
    func buildView(page destination: Destination.Navigation) -> some View {
        switch destination {
        case let .register(props):
            LocbookRegisterView(props: props)
        case .actions:
            LocbookActionsView()
        }
    }

    // MARK: - Private Methods

    private func navigate(to destination: Destination.Navigation) {
        self.path.append(destination)
    }

}
