import Foundation
import Factory

class TaskRepository {

    let network: Network

    init(network: Network) {
        self.network = network
    }
    var token = Container.shared.appData
    func taskRegister(with locBookTask: LocbookTask, token: String , childrenID: Int) async -> ResponseMessage {
        //let task = TaskRegister(locBookTask: locBookTask)
        guard let categoryId = locBookTask.categoryId?.description else {
            return ResponseMessage(message: "categoryID error")
        }

        guard let shift = locBookTask.shift else {
            return ResponseMessage(message: "shif error")
        }

        guard let frequency = locBookTask.frequency else {
            return ResponseMessage(message: "frequency error")
        }

        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: Endpoint.task)
            .with(method: .post)
            .with(body: JSONParser.parseData(from: [
                "childrenId": "\(String(describing: childrenID))",
                "categoryId": "\(String(describing: categoryId))",
                "shift": "\(String(describing: shift))",
                "frequency": [ frequency.map { $0.rawValue }],
                "order": "\(String(describing: locBookTask.order))"
                ])
                )
            .with(addHeaderName: "Authorization", value: "Bearer \(token)")
            .with(addHeaderName: "Accept", value: "*/*")
            .with(addHeaderName: "User-Agent", value: "LoryBlu(iOS)")
            .with(addHeaderName: "Content-Type", value: "application/json")
            .build()

        do {
            let response = try await network.request(request: request, returning: ResponseMessage.self)
            return response
        } catch {
            return ResponseMessage()
        }
    }
}

//struct TaskRegister: Codable {
//
//    enum CodingKeys: String, CodingKey {
//        case childrenId
//        case categoryId
//        case shift
//        case frequency
//        case order
//    }
//    var locBookTask: LocbookTask
//
//    init(locBookTask: LocbookTask) {
//        self.locBookTask = locBookTask
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        locBookTask.childrenId =  try container.decode(Int.self, forKey: .childrenId)
//        locBookTask.categoryId = try container.decode(String.self, forKey: .categoryId)
//        locBookTask.shift = try container.decode(LocbookTask.Shift.self, forKey: .shift)
//        locBookTask.frequency = try container.decode([LocbookTask.Frequency].self, forKey: .frequency)
//    }
//
//    func econde(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(self.locBookTask.childrenId, forKey: .childrenId)
//        try container.encodeIfPresent(locBookTask.categoryId.self, forKey: .categoryId)
//        try container.encodeIfPresent(locBookTask.shift.self, forKey: .shift)
//        try container.encodeIfPresent(locBookTask.frequency.self, forKey: .frequency)
//    }
//}
