import Foundation

class TaskCacheBuilder {

    private var tasks: [Int: TaskModel] = [:]

    func addStudyList(studyTasks: [TaskModel]) {
        studyTasks.forEach { task in
            tasks[task.locbookTask.id!] = task
        }
    }

    func addRoutineList(routineTasks: [TaskModel]) {
        routineTasks.forEach { task in
            tasks[task.locbookTask.id!] = task
        }
    }

    func build() -> [Int: TaskModel] {
        return self.tasks
    }
}
