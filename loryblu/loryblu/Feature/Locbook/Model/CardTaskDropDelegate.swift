import SwiftUI

struct CardTaskDropDelegate: DropDelegate {
    var taskData: TasksViewModel
    var task: TaskModel

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        // MARK: - TODO fazer patch da task na API
        taskData.currentTask = nil
        return true
    }

    func dropEntered(info: DropInfo) {

        if taskData.currentTask == nil {
            taskData.currentTask = task
        }

        let fromIndex = taskData.taskFilter?.tasks.firstIndex { (taks) -> Bool in
            return taks.uuid == taskData.currentTask?.uuid
        } ?? 0

        let toIndex = taskData.taskFilter?.tasks.firstIndex { (taks) -> Bool in
            return taks.uuid  == self.task.uuid
        } ?? 0

        if fromIndex != toIndex {
            withAnimation {
                let fromTask = taskData.taskFilter?.tasks[fromIndex]
                taskData.taskFilter?.tasks[fromIndex] = taskData.taskFilter?.tasks[toIndex] ?? TaskModel(
                    locbookTask: LocbookTask(),
                    image: "",
                    backgroundCard: Color.white
                )
                taskData.taskFilter?.tasks[toIndex] = fromTask ?? TaskModel(
                    locbookTask: LocbookTask(),
                    image: "",
                    backgroundCard: Color.white
                )
            }
        }
    }
}
