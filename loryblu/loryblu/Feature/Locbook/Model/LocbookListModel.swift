import Foundation
import Factory
class LocbookListModel: ObservableObject {

    @Injected(\.appData) var appData

    private var repository = Container.shared.taskRepository()

    @MainActor

    func loadTask(with weekDays:[String]) async throws -> [TaskRequest] {
        let result =  try await repository.loadTaskRegister(with: weekDays, childrenID: appData.childrenId, token: appData.token)
        return result
    }

    func configCardStudy(with taskRequeste: TaskRequest) -> CardTaskRegistered {

        var nameAction = ""
        var imageTask = ""
        var nameTask = ""

        if !taskRequeste.data.study.isEmpty {
            nameAction = LBStrings.Locbook.titleRotine
            imageTask = taskRequeste.categoryId
            nameTask = taskRequeste.categoryTitle
        }
        let card: CardTaskRegistered = CardTaskRegistered(nameAction: nameAction, imageTask: imageTask, nameTask: nameTask, backgroundCard: LBColor.buttonGenderEnable, isSecurity: .constant(true))
        return card
    }

}
