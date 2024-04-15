import SwiftUI

struct LocbookNavigationStack: View {
    enum NavigationTitle {
        case edit, new

        var title: String {
            switch self {
            case .edit:
                return LBStrings.General.edit
            case .new:
                return LBStrings.General.newTask
            }
        }
    }

    typealias NavigationCoordinator = LocbookNavigationCoordinator

    struct Props {
        let onFinish: ClosureType.VoidVoid?
        let onDismiss: ClosureType.VoidVoid?
    }

    @ObservedObject var coordinator: NavigationCoordinator
    @Environment(\.dismiss) private var dismiss
    @State private var navigationTitle = NavigationTitle.new

    private let props: Props

    init(props: Props) {
        coordinator = .init()
        self.props = props
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildView(
                page: .board(
                    .init(
                        onNewTask: {
                            navigationTitle = .new
                            pushLocbookActions()
                        },
                        onEditTask: {
                            navigationTitle = .edit
                            pushLocbookActions()
                        }
                    )
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
                task: LocbookTask(), title: navigationTitle.title,
                onNext: { task, action in
                    pushLocbookTasks(task: task, action: action)
                },
                onClose: { dismiss() }
            )
        )
    }

    private func pushLocbookTasks(task: LocbookTask, action: Int) {
        let loryRouteId = 1
        var actionType: LocbookTasksView.ActionType = .study

        if action == loryRouteId {
            actionType = .routine
        }

        coordinator.pushTasksView(
            props: LocbookTasksView.Props(
                task: task,
                title: navigationTitle.title,
                actionType: actionType,
                onNext: { newTask in
                    pushLocbookRoutine(task: newTask) },
                onClose: { dismiss() }
            )
        )
    }

    private func pushLocbookRoutine(task: LocbookTask) {
        coordinator.pushTasksFrequency(
            props: FrequencyRotineView.Props(
                task: task, title: navigationTitle.title,
                onNext: { task in pushSummaryView(task: task) },
                onClose: { dismiss() }
            )
        )
    }

    private func pushSummaryView(task: LocbookTask) {
        coordinator.pushSummaryView(
            props: LocbookSummaryView.Props(
                task: task, title: navigationTitle.title,
                onSubmit: { pushFinishView() },
                onClose: { dismiss() }
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
