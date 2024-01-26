import Foundation

struct LocbookActionModel {
    
    private typealias Localizable = LBStrings.Locbook
 
    struct Action {
        let name: String
        let image: LBIcon
    }
    
    var actions: [Action] = [
        .init(name: Localizable.NameImage.loryStudy, image: .dailyStudy),
        .init(name: Localizable.NameImage.loryRotine, image: LBIcon.dailyRotine)
    ]
    
    var options: [ImageLabel] {
        actions.map {
            ImageLabel(
                image: $0.image.rawValue,
                name: $0.name,
                font: LBFont.titleAction,
                segment: .locbook
            )
        }
    }
}
