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

    func configCard(with task: Study) -> CardTaskRegistered {
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

//        "id_school" = "44f29121-b7b1-4d1a-bbff-5f1cf2fc5497";
//        "id_reinforcement" = "e9f17f88-7c94-4953-a1eb-bce035c483d8";
//        "id_anguages" = "8c004aa0-961d-4ec4-b6fe-cb70cbc0c4c1";
//        "id_sport" = "648d5ce9-6880-476e-bf98-0d7139aadb2c";
//        "id_reading" = "549a70f6-3f9c-4640-9b1e-b23d69f1d213";
//        "id_music" = "6166d506-b5f0-4feb-b900-e78d23f1e6ac";
//        "id_psychologist" = "49f9aed1-e583-427c-82bf-a596513a6707";
//        "id_speech_therapist" = "aa61d985-93a9-4ee0-b465-2e73848c84a8";
//        "id_pedagogue" = "1b2f2a80-9b3e-455d-aab4-66ba68e6dac0";
//        "id_occupational_therapist" = "7da68252-143d-4e98-b5b0-17c7ea9953a3"; ***
//        "id_bathTime" = "6dfc15bb-f422-4c75-b2cc-bf3e9806c76a";
//        "id_brushTeeth" = "61123e8a-22af-421f-8e0d-6356c920803b"; ****
//        "id_breakfast" = "15d2ceb0-ab06-4cf6-8e46-54ccf8c1e556";
//        "id_lunch" = "5431e6bf-c1d3-43b6-9289-843ca6455ee3";
//        "id_snack" = "27e4089a-8643-487d-9634-2332419c2adc";
//        "id_dinner" = "a6284261-134d-4c96-ad1c-4afd50ae493d";
//        "id_water" = "161bf998-4bf3-4c9f-bd72-1542bad40ed9";
//        "id_play" = "86008ded-8ba1-4719-a55e-ef6d8d4cb8b1";
//        "id_watchtv" = "bc920d36-d024-481b-9923-3d2d6a478a81";
//        "id_tvgame" = "63631065-7485-42d1-a9c1-523787954f56";
    }
}
