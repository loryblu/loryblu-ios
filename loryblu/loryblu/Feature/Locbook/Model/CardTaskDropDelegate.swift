import SwiftUI

struct CardTaskDropDelegate: DropDelegate {
    var taskData = TasksViewModel()
    var task: TaskModel

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        return true
    }

    func dropEntered(info: DropInfo) {

        let fromIndex = taskData.tasks.firstIndex { (taks) -> Bool in
            return taks.uuid == taskData.currentTask?.uuid
        } ?? 0

        let toIndex = taskData.tasks.firstIndex { (taks) -> Bool in
            return taks.uuid == self.task.uuid
        } ?? 0

        if fromIndex != toIndex {
            withAnimation {
                let fromTask = taskData.tasks[fromIndex]
                taskData.tasks[fromIndex] = fromTask
            }

        }
    }

}


