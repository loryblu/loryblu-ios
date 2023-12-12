import SwiftUI

@MainActor
class LocbookNavigationCoordinator: ObservableObject {
        
    enum Destination {
        enum Navigation: Hashable {            
            case register(LocbookRegisterView.Props)
            case actions(LocbookActionsView.Props)
            case tasks(LocbookTasksView.Props)
            case frequency(FrequencyRotineView.Props)
            case finishView(DoneView.Props)
        }
        
        enum FullScreen: Hashable {
            case finishView(DoneView.Props)
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
    
    func pushActionsView(props: LocbookActionsView.Props) {
        navigate(to: .actions(props))
    }

    func pushTasksView(props: LocbookTasksView.Props) {
        navigate(to: .tasks(props))
    }

    func pushTasksFrequency(props: FrequencyRotineView.Props) {
        navigate(to: .frequency(props))
    }
    
    func pushFinishScreen(props: DoneView.Props) {
        navigate(to: .finishView(props))
    }

    @ViewBuilder
    func buildView(page destination: Destination.Navigation) -> some View {
        switch destination {
        case let .register(props):
            LocbookRegisterView(props: props)
        case let .actions(props):
            LocbookActionsView(props: props)
        case let .tasks(props):
            LocbookTasksView(props: props)
        case let .frequency(props):
            FrequencyRotineView(props: props)
        case let .finishView(props):
            DoneView(props: props)
        }
    }
    
    @ViewBuilder
    func buildView(cover destination: Destination.FullScreen) -> some View {
        switch destination {
        case let .finishView(props):
            DoneView(props: props)
        }
    }

    // MARK: - Private Methods

    private func navigate(to destination: Destination.Navigation) {
        self.path.append(destination)
    }

}
