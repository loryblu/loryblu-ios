import Foundation

struct LocbookActionModel {
    private typealias Localizable = LBStrings.NameImage

    struct Action {
        let name: String
        let image: LBIcon
    }

    var actions: [Action] = [
        .init(name: Localizable.loryStudy, image: .dailyStudy),
        .init(name: Localizable.loryRotine, image: LBIcon.dailyRotine)
    ]
    
    var options: [ImageLabel] {
        actions.map {
            ImageLabel(
                image: $0.image.rawValue,
                name: $0.name,
                font: LBFont.titleAction,
                segment: .locbook)
        }
    }
}
