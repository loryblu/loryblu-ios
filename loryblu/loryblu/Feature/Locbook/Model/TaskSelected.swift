import Foundation

class TaskSelected : ObservableObject {
    @Published var locbookTask: LocbookTask?
    
    func setupTaskSelected(task:LocbookTask) {
        locbookTask = task
    }
    
    func resetTaskSelected() {
        locbookTask = nil
    }
}
