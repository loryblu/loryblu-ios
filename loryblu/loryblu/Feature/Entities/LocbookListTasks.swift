import Foundation

struct LocbookListTasks {
    private typealias Localizable = LBStrings.NameImage

    static let study: [ImageLabel] = [
        ImageLabel(
            image: LBIcon.school.rawValue,
            name: Localizable.school,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.school),
        ImageLabel(
            image: LBIcon.reinforcement.rawValue,
            name: Localizable.reinforcement,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.reinforcement),
        ImageLabel(
            image: LBIcon.reading.rawValue,
            name: Localizable.reading,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.reading),
        ImageLabel(
            image: LBIcon.language.rawValue,
            name: Localizable.languages,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.languages),
        ImageLabel(
            image: LBIcon.music.rawValue,
            name: Localizable.music,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.music),
        ImageLabel(
            image: LBIcon.speechTherapy.rawValue,
            name: Localizable.speechTherapist,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.speechTherapist),
        ImageLabel(
            image: LBIcon.sport.rawValue,
            name: Localizable.sport,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.sport),
        ImageLabel(
            image: LBIcon.pedagogue.rawValue,
            name: Localizable.pedagogue,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.pedagogue),
        ImageLabel(
            image: LBIcon.psychologist.rawValue,
            name: Localizable.psychologist,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.psychologist),
        ImageLabel(
            image: LBIcon.therapy.rawValue,
            name: Localizable.therapist,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.therapist)
    ]

    static let rotine: [ImageLabel] = [
        ImageLabel(
            image: LBIcon.bathTime.rawValue,
            name: Localizable.bathTime,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.bathTime) ,
        ImageLabel(
            image: LBIcon.brushTeeth.rawValue,
            name: Localizable.brushTeeth,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.brushTeeth),
        ImageLabel(
            image: LBIcon.morning.rawValue,
            name: Localizable.morning,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.morning),
        ImageLabel(
            image: LBIcon.lunch.rawValue,
            name: Localizable.lunch,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.lunch),
        ImageLabel(
            image: LBIcon.dinner.rawValue,
            name: Localizable.dinner,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.dinner),
        ImageLabel(
            image: LBIcon.snack.rawValue,
            name: Localizable.snack,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.snack),
        ImageLabel(
            image: LBIcon.water.rawValue,
            name: Localizable.water,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.water),
        ImageLabel(
            image: LBIcon.play.rawValue,
            name: Localizable.play,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.play),
        ImageLabel(
            image: LBIcon.watchtv.rawValue,
            name: Localizable.watchTv,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.watchTv),
        ImageLabel(
            image: LBIcon.tvgame.rawValue,
            name: Localizable.tvgame,
            font: LBFont.titleTask, segment: .locbook,
            categoryID: LBStrings.CategoryID.tvgame)
    ]

}
