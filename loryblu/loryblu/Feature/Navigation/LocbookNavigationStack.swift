import SwiftUI

struct LocbookNavigationStack: View {
    enum NavigationTitle {
        case edit, new

        var title: String {
            switch self {
            case .edit:
                return LBStrings.Toolbar.editTaskTitle
            case .new:
                return LBStrings.Toolbar.addTaskTitle
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
                            pushLocbookActions(locbookTask: LocbookTask())
                        },
                        onEditTask: { locbookTask in
                            navigationTitle = .edit
                            pushSummaryView(task: locbookTask, addOrEdit: AddOrEditType.edit)
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

    private func pushLocbookActions(locbookTask: LocbookTask, addOrEdit: AddOrEditType = AddOrEditType.add) {
        coordinator.pushActionsView(
            props: LocbookActionsView.Props(
                task: locbookTask, title: navigationTitle.title,
                addOrEdit: addOrEdit,
                onNext: { task in
                    pushLocbookTasks(task: task, addOrEdit: addOrEdit)
                },
                onClose: { dismiss() }
            )
        )
    }

    private func pushLocbookTasks(task: LocbookTask, addOrEdit: AddOrEditType) {
        var actionType: LocbookTasksView.ActionType = .study
        actionType = task.categoryTitle == LBStrings.Locbook.titleStudy ? .study : .routine

        coordinator.pushTasksView(
            props: LocbookTasksView.Props(
                addOrEdit: addOrEdit,
                task: task,
                title: navigationTitle.title,
                actionType: actionType,
                onNext: { newTask in
                    addOrEdit == .add ? pushLocbookRoutine(task: newTask) : pushSummaryView(
                        task: newTask, addOrEdit: addOrEdit)
                },
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

    private func pushSummaryView(task: LocbookTask, addOrEdit: AddOrEditType = AddOrEditType.add) {
        coordinator.pushSummaryView(
            props: LocbookSummaryView.Props(
                task: task, title: navigationTitle.title,
                onSubmitNewTask: {
                    pushFinishView(message: LBStrings.SummaryLocbook.summaryFinishedNewTaskMessage)
                },
                onSubmitEditedTask: {
                    pushFinishView(message: LBStrings.SummaryLocbook.summaryFinishedEditTaskMessage)
                },
                onEditTaskPath: { path in
                    switch path {
                    case .category:
                        return pushLocbookActions(locbookTask: task, addOrEdit: addOrEdit)
                    case .task:
                        return pushLocbookTasks(task: task, addOrEdit: addOrEdit)
                    }
                },
                onClose: {
                    addOrEdit == .add ? dismiss() : coordinator.popToRoot()
                },
                addOrEdit: addOrEdit
            )
        )
    }

    private func pushFinishView(message: String) {
        coordinator.pushFinishScreen(
            props: .init(
                message: message,
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
