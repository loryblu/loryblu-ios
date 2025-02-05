//
//  AccessControlView.swift
//  LoryBlu
//
//  Created by Suh on 04/02/25.
//

import SwiftUI

struct AccessControlView: View {
    @State var isAvailable: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(LBStrings.Menu.securityTextInfo)
                .font(LBFont.bodySmall)
                .padding(.bottom, 40)

            VStack(spacing: 16) {
                LBAccessControlCell(
                    isLoccked: isAvailable,
                    title: LBStrings.Menu.profileChild,
                    description: LBStrings.AccessControl.infoChild,
                    image: LBIcon.childTree.image
                )

                LBAccessControlCell(
                    isLoccked: isAvailable,
                    title: LBStrings.Menu.profileUser,
                    description: LBStrings.AccessControl.infoChild,
                    image: LBIcon.childTree.image
                )

                LBAccessControlCell(
                    isLoccked: isAvailable,
                    title: LBStrings.Locbook.title,
                    description: LBStrings.AccessControl.infoChild,
                    image: LBIcon.clipboard.image
                )

                LBAccessControlCell(
                    isLoccked: isAvailable,
                    title: LBStrings.Menu.exit,
                    description: LBStrings.AccessControl.infoChild,
                    image: LBIcon.exit.image
                )
            }
        }
        .padding(20)
    }
}

#Preview {
    AccessControlView(isAvailable: false)
}
