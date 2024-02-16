import Foundation
import Factory

class TaskRepository {
    
    let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    var token = Container.shared.appData
    
    func taskRegister(with locBookTask: LocbookTask, token: String, childrenID: Int) async -> Bool {
        
        guard let categoryId = locBookTask.categoryId?.description else {
            return false
        }
        
        guard let shift = locBookTask.shift else {
            return false
        }
        
        guard let frequency = locBookTask.frequency else {
            return false
        }
        
        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: Endpoint.task)
            .with(method: .post)
            .with(body: JSONParser.parseData(from: [
                "childrenId": childrenID,
                "categoryId": categoryId,
                "shift": "\(shift)",
                "frequency": frequency.map { $0.rawValue },
                "order": 0
            ]))
            .with(addHeaderName: "Authorization", value: "Bearer \(token)")
            .with(addHeaderName: "User-Agent", value: "LoryBlu(iOS)")
            .with(addHeaderName: "Content-Type", value: "application/json")
            .build()
        
        do {
            _ = try await network.request(request: request, returning: ResponseMessage.self)
            return true
        } catch {
            return false
        }
    }
    
    func fetchTasks(token: String, childrenId: Int) async -> [TaskModel]? {
        
        var tasks: [TaskModel] = []
        
        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: "\(Endpoint.task)?childreId=\(childrenId)&frequency=sun,mon,tue,wed,thu,fri,sat")
            .with(method: .get)
            .with(addHeaderName: "Authorization", value: "Bearer \(token)")
            .build()
        
        do {
            let result = try await network.request(request: request, returning: ResponseData<NetworkDataModel>.self)
            
            tasks = getStudyTasks(studyTasks: result.data?.study ?? [])
            
            tasks += getRoutineTasks(routineTasks: result.data?.routine ?? [])
            
            return tasks
        } catch {
            return tasks
        }
    }
}

extension TaskRepository {
    
    func getStudyTasks(studyTasks: [TasksNetworkModel]) -> [TaskModel] {
        
        return studyTasks.map { (task: TasksNetworkModel) -> TaskModel in
            
            let shift = getShift(shift:task.shift)
            
            let frequency = frequencyMapper(frequency:task.frequency)
            
            let locbooktask = LocbookTask(childrenId: task.childrenId, shift: shift,frequency: frequency, order: task.order, categoryId: task.categoryId,categoryTitle: task.categoryTitle,updatedAt: DateFormatter().date(from:task.updatedAt)!)
            
            return TaskModel(actionType: LBStrings.Locbook.titleStudy, locbookTask: locbooktask)
        }
    }
    
    func getRoutineTasks(routineTasks: [TasksNetworkModel]) -> [TaskModel] {
        
        return routineTasks.map { (task: TasksNetworkModel) -> TaskModel in
            
            let shift = getShift(shift:task.shift)
            
            let frequency = frequencyMapper(frequency:task.frequency)
            
            let locbooktask = LocbookTask(childrenId: task.childrenId, shift: shift,frequency: frequency, order: task.order, categoryId: task.categoryId,categoryTitle: task.categoryTitle,updatedAt: DateFormatter().date(from:task.updatedAt)!)
            
            return TaskModel(actionType: LBStrings.Locbook.titleRotine, locbookTask: locbooktask)
        }
    }
    
    private func frequencyMapper(frequency: [String]) -> [LocbookTask.Frequency] {
        return frequency.map { (item: String) -> LocbookTask.Frequency in
            return getFrequency(frequency:item)
        }
    }
    
    private func getFrequency(frequency: String) -> LocbookTask.Frequency {
        return switch frequency {
        case "sun" : LocbookTask.Frequency.sun
        case "mon" : LocbookTask.Frequency.mon
        case "tue" : LocbookTask.Frequency.tue
        case "wed" : LocbookTask.Frequency.wed
        case "thu" : LocbookTask.Frequency.thu
        case "fri" : LocbookTask.Frequency.fri
        default : LocbookTask.Frequency.sat
        }
    }
    private func getShift(shift: String) -> LocbookTask.Shift {
        return switch shift {
        case "morning" : LocbookTask.Shift.morning
        case "afternoon" : LocbookTask.Shift.afternoon
        default :
            LocbookTask.Shift.night
        }
    }
    
}
