import Foundation
import SwiftUI
import Factory

class TaskRepository {
    let network: Network
    let token = Container.shared.appData
    private var cache: [Int: TaskModel]?

    init(network: Network) {
        self.network = network
    }

    func taskRegister(with locBookTask: LocbookTask, token: String, childrenID: Int) async -> Bool {
        guard let categoryId = locBookTask.categoryId?.description else {
            return false
        }

        guard let shift = locBookTask.shift else { return false }
        guard let frequency = locBookTask.frequency else { return false }

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
            .build()

        do {
            let response = try await network.request(
                request: request,
                returning: ResponseData<ResponseTaskCreated>.self
            )

            if response.isSuccess ?? false {
                let task = response.data?.task
                let locbooktask = LocbookTask(
                    id: task!.id,
                    shift: shift,
                    frequency: frequency,
                    order: task!.order,
                    categoryId: categoryId,
                    categoryTitle: locBookTask.categoryTitle,
                    taskTitle: locBookTask.categoryTitle,
                    updatedAt: Date()
                )

                if cache != nil {
                    cache?[task!.id] = locbooktask.toTaskModel()
                } else {
                    cache = [:]
                    cache?[task!.id] = locbooktask.toTaskModel()
                }
            }
            return response.isSuccess ?? false
        } catch {
            return false
        }
    }

    func taskEdit(with locBookTask: LocbookTask, token: String, childrenID: Int) async -> Bool {
        guard
            let categoryId = locBookTask.categoryId,
            let shift = locBookTask.shift,
            let frequency = locBookTask.frequency,
            let taskId = locBookTask.id
        else {
            return false
        }

        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: "\(Endpoint.task)?childrenId=\(childrenID)&taskId=\(taskId)")
            .with(method: .patch)
            .with(body: JSONParser.parseData(from: [
                "childrenId": childrenID,
                "categoryId": categoryId,
                "shift": "\(shift)",
                "frequency": frequency.map { $0.rawValue },
                "order": 0
            ]))
            .with(addHeaderName: "Authorization", value: "Bearer \(token)")
            .with(addHeaderName: "User-Agent", value: "LoryBlu(iOS)")
            .build()

        do {
            let response = try await network.request(request: request, returning: ResponseMessage.self)

            if response.isSuccess {
                updateCache(taskEdited: locBookTask)
            }

            return response.isSuccess
        } catch {
            return false
        }
    }

    func fetchTasks(
        token: String,
        childrenId: Int,
        frequency: String = "frequency=sun,mon,tue,wed,thu,fri,sat",
        perPage: Int = 70
    ) async -> [Int: TaskModel] {

        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: "\(Endpoint.task)?childrenId=\(childrenId)&\(frequency)&perPage=\(perPage)")
            .with(method: .get)
            .with(addHeaderName: "Authorization", value: "Bearer \(token)")
            .with(addHeaderName: "Content-Type", value: "application/json")
            .build()

        do {
            if cache == nil {
                let result = try await network.request(
                    request: request,
                    returning: ResponseData<NetworkDataModel>.self
                )

                let cacheBuilder = TaskCacheBuilder()
                cacheBuilder.addStudyList(
                    studyTasks: getTasks(
                        type: LBStrings.Locbook.titleStudy,
                        tasks: result.data?.study ?? []
                    )
                )
                cacheBuilder.addRoutineList(
                    routineTasks: getTasks(
                        type: LBStrings.Locbook.titleRotine,
                        tasks: result.data?.routine ?? []
                    )
                )
                cache = cacheBuilder.build()
            }
            return cache ?? [:]
        } catch {
            return cache ?? [:]
        }
    }

    func deleteTask(token: String, childrenId: Int, taskId: Int?) async -> Bool {
        do {
            let request = RequestModel.Builder()
                .with(baseURL: Server.baseURL)
                .with(path: "\(Endpoint.task)?childrenId=\(childrenId)&taskId=\(taskId!)")
                .with(method: .delete)
                .with(addHeaderName: "Authorization", value: "Bearer \(token)")
                .with(addHeaderName: "Content-Type", value: "application/json")
                .build()

            let response = try await network.request(request: request, returning: ResponseMessage.self)

            if response.isSuccess {
                removeFromCache(taskId: taskId!)
            }

            return response.isSuccess
        } catch {
            return false
        }
    }
}

extension TaskRepository {
    func getTasks(
        type: String,
        tasks: [TasksNetworkModel]
    ) -> [TaskModel] {
        return tasks.toTasksModel(category: type)
    }

    func updateCache(taskEdited: LocbookTask) {
        do {
            cache?.updateValue(taskEdited.toTaskModel(), forKey: taskEdited.id!)
        }
    }

    func removeFromCache(taskId: Int) {
        cache?.removeValue(forKey: taskId)
    }
}
