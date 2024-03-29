import SwiftUI

struct LocbookNavigationStack: View {
    typealias NavigationCoordinator = LocbookNavigationCoordinator
    
    struct Props {
        let onFinish: ClosureType.VoidVoid?
        let onDismiss: ClosureType.VoidVoid?
    }
    
    @ObservedObject var coordinator: NavigationCoordinator
    @Environment(\.dismiss) private var dismiss
    
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
        coordinator.pushActionsView(
            props: LocbookActionsView.Props(
                task: LocbookTask(),
                onNext: { task in
                    pushLocbookTasks(task: task)
                }
            )
        )
    }
    
    private func pushLocbookTasks(task: LocbookTask) {
        coordinator.pushTasksView(
            props: LocbookTasksView.Props(
                task: task,
                onNext: { pushLocbookRoutine(task: task) }
            )
        )
    }
    
    private func pushLocbookRoutine(task: LocbookTask) {
        coordinator.pushTasksFrequency(
            props: FrequencyRotineView.Props(
                task: task,
                onSubmit: { pushFinishView() }
            )
        )
    }
    
    private func pushFinishView() {
        coordinator.pushFinishScreen(
            props: .init(
                message: "Nova Tarefa criada com sucesso",
                onClose: { dismiss() }
            )
        )
    }

}

struct LocbookNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        LocbookNavigationStack(props: .init(onFinish: nil, onDismiss: nil))
            .environmentObject(AppData())
    }
}
