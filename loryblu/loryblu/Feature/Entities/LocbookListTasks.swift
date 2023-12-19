import Foundation

struct LocbookListTasks {
    private typealias Localizable = LBStrings.Locbook.NameImage

    static let study: [ImageLabel] = [
        ImageLabel(
            image: LBIcon.school.rawValue,
            name: Localizable.school,
            font: LBFont.titleTask, segment: .locbook) ,
        ImageLabel(
            image: LBIcon.reinforcement.rawValue,
            name: Localizable.reinforcement,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.reading.rawValue,
            name: Localizable.reading,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.language.rawValue,
            name: Localizable.languages,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.music.rawValue,
            name: Localizable.music,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.speechTherapy.rawValue,
            name: Localizable.speechTherapist,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.sport.rawValue,
            name: Localizable.sport,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.pedagogue.rawValue,
            name: Localizable.pedagogue,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.psychologist.rawValue,
            name: Localizable.psychologist,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.therapy.rawValue,
            name: Localizable.therapist,
            font: LBFont.titleTask, segment: .locbook)
    ]

    static let rotine: [ImageLabel] = [
        ImageLabel(
            image: LBIcon.bathTime.rawValue,
            name: Localizable.bathTime,
            font: LBFont.titleTask, segment: .locbook) ,
        ImageLabel(
            image: LBIcon.brushTeeth.rawValue,
            name: Localizable.brushTeeth,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.morning.rawValue,
            name: Localizable.morning,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.lunch.rawValue,
            name: Localizable.lunch,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.dinner.rawValue,
            name: Localizable.dinner,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.snack.rawValue,
            name: Localizable.snack,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.water.rawValue,
            name: Localizable.water,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.play.rawValue,
            name: Localizable.play,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.watchtv.rawValue,
            name: Localizable.watchTv,
            font: LBFont.titleTask, segment: .locbook),
        ImageLabel(
            image: LBIcon.tvgame.rawValue,
            name: Localizable.tvgame,
            font: LBFont.titleTask, segment: .locbook)
    ]

}
