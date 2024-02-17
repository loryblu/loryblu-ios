import Foundation
import Factory
import SwiftUI
class LocbookListModel: ObservableObject {

    @Injected(\.appData) var appData

    private var repository = Container.shared.taskRepository()

    @MainActor

    func loadTask(with weekDays:[String]) async throws -> TaskRequest {
        let result =  try await repository.loadTaskRegister(with: weekDays,
                                                            childrenID: appData.childrenId,
                                                            token: appData.token)
        return result
    }

    func configCardStudy(with task: Study) -> CardTaskRegistered {
        let card = CardTaskRegistered(nameAction: LBStrings.Locbook.titleStudy,
                                      imageTask: giveBackImageTask(with: task.categoryId),
                                      nameTask: task.categoryTitle,
                                      backgroundCard: LBColor.buttonBackgroundLight,
                                      isSecurity: .constant(false))
        return card
    }

    func configCardRoutine(with task: Routine) -> CardTaskRegistered {
        let card = CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine,
                                      imageTask: giveBackImageTask(with: task.categoryId),
                                      nameTask: task.categoryTitle,
                                      backgroundCard: LBColor.buttonBackgroundLight,
                                      isSecurity: .constant(false))
        return card
    }

    func giveBackImageTask(with categoryId: String) -> String {
        if categoryId == LBStrings.CategoryID.school {
            return LBIcon.school.rawValue
        }

        if categoryId == LBStrings.CategoryID.reinforcement {
            return LBIcon.reinforcement.rawValue
        }

        if categoryId == LBStrings.CategoryID.languages {
            return LBIcon.language.rawValue
        }

        if categoryId == LBStrings.CategoryID.sport {
            return LBIcon.sport.rawValue
        }

        if categoryId == LBStrings.CategoryID.reading {
            return LBIcon.reading.rawValue
        }

        if categoryId == LBStrings.CategoryID.music {
            return LBIcon.music.rawValue
        }

        if categoryId == LBStrings.CategoryID.psychologist {
            return LBIcon.psychologist.rawValue
        }

        if categoryId == LBStrings.CategoryID.speechTherapist {
            return LBIcon.speechTherapy.rawValue
        }

        if categoryId == LBStrings.CategoryID.pedagogue {
            return LBIcon.pedagogue.rawValue
        }

        if categoryId == LBStrings.CategoryID.bathTime {
            return LBIcon.bathTime.rawValue
        }

        if categoryId == LBStrings.CategoryID.brushTeeth {
            return LBIcon.brushTeeth.rawValue
        }
        if categoryId == LBStrings.CategoryID.lunch {
            return LBIcon.lunch.rawValue
        }

        if categoryId == LBStrings.CategoryID.lunch {
            return LBIcon.lunch.rawValue
        }

        if categoryId == LBStrings.CategoryID.snack {
            return LBIcon.snack.rawValue
        }

        if categoryId == LBStrings.CategoryID.dinner {
            return LBIcon.dinner.rawValue
        }

        if categoryId == LBStrings.CategoryID.water {
            return LBIcon.water.rawValue
        }

        if categoryId == LBStrings.CategoryID.play {
            return LBIcon.play.rawValue
        }

        if categoryId == LBStrings.CategoryID.watchTv {
            return LBIcon.watchtv.rawValue
        }

        if categoryId == LBStrings.CategoryID.tvgame {
            return LBIcon.tvgame.rawValue
        } else {
            return LBIcon.tvgame.rawValue
        }

//        "id_occupational_therapist" = "7da68252-143d-4e98-b5b0-17c7ea9953a3"; ***
//        "id_breakfast" = "15d2ceb0-ab06-4cf6-8e46-54ccf8c1e556"; ****

    }
}
