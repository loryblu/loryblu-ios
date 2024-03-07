import SwiftUI

struct CardTaskDropDelegate: DropDelegate {
    var taskData = TasksViewModel()
    var task: ListTasksView
    func performDrop(info: DropInfo) -> Bool {
        return true
    }

    func dropEntered(info: DropInfo) {
        let fromIndex = taskData.tasks.firstIndex { (taks) -> Bool in
            return taks == self.task.draggedTask
        }
    }

}


