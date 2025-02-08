//
//  AccessControlView.swift
//  LoryBlu
//
//  Created by Suh on 04/02/25.
//

import SwiftUI

struct AccessControlView: View {
    let localizable = LBStrings.AccessControl.self

    struct Props {
        var isAvaliable: Bool
        var onClose: ClosureType.VoidVoid?
    }

    let props: Props

    init(props: Props) {
        self.props = props
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(localizable.textInfo)
                    .font(LBFont.bodySmall)
                    .lineLimit(2)
                    .padding(.top, 12)

                VStack(spacing: 16) {
                    LBAccessControlCell(
                        isLoccked: props.isAvaliable,
                        title: LBStrings.Menu.profileChild,
                        description: localizable.infoChild,
                        image: LBIcon.childTree.image
                    )

                    LBAccessControlCell(
                        isLoccked: props.isAvaliable,
                        title: LBStrings.Menu.profileUser,
                        description: localizable.infoChild,
                        image: LBIcon.childTree.image
                    )

                    LBAccessControlCell(
                        isLoccked: props.isAvaliable,
                        title: LBStrings.Locbook.title,
                        description: localizable.infoChild,
                        image: LBIcon.clipboard.image
                    )

                    LBAccessControlCell(
                        isLoccked: props.isAvaliable,
                        title: LBStrings.Menu.exit,
                        description: localizable.infoChild,
                        image: LBIcon.exit.image
                    )
                }.padding(.top, 24)
            }
        }
        .locbookToolbar(title: LBStrings.Menu.security, showCloseButton: false) {
            props.onClose?()
        }
        .padding(20)
    }
}

extension AccessControlView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    AccessControlView(props: .init(isAvaliable: false))
}
