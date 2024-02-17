import Foundation
import Factory
import SwiftUI
class LocbookListModel: ObservableObject {

    @Injected(\.appData) var appData

    private var repository = Container.shared.taskRepository()

    @MainActor

    func loadTask(with weekDays:[String]) async throws -> TaskRequest {
        let result =  try await repository.loadTaskRegister(with: weekDays, childrenID: appData.childrenId, token: appData.token)
        print(result)
        return result
    }

    func configCard(with task: Study) -> CardTaskRegistered {
        var card = CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: task.categoryId, nameTask: task.categoryTitle, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: .constant(true))
        return card
    }


}
