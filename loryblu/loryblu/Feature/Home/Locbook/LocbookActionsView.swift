//
//  LocbookActionsView.swift
//  LoryBlu
//
//  Created by Suh on 06/11/23.
//

import SwiftUI

struct LocbookActionsView: View {
    typealias Localizable = LBStrings.Locbook

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text(Localizable.title)
                .font(LBFont.titleAction)
                .foregroundStyle(LBColor.titlePrimary)

            Text(LBStrings.Locbook.actionTitle)
                .font(LBFont.buttonSmall)
                .foregroundStyle(LBColor.titlePrimary)

            actions

            LBButton(
                title: Localizable.button,
                style: .primaryActivated) {
                    //
                }
                .padding(.top, 15)
        }
        .padding(.init(top: 15, leading: 24, bottom: 50, trailing: 24))

    }

    var actions: some View {
        VStack(spacing: 24) {
            Group {
                ImageLabel(image: "study_lory", name: Localizable.NameImage.loryStudy, backImage: LBColor.backgroundCards, font: LBFont.titleAction)

                ImageLabel(image: LBIcon.dailyRotine.rawValue, name: Localizable.NameImage.loryRotine, backImage: LBColor.backgroundCards, font: LBFont.titleAction)
                    .opacity(0.6)

            }
            .frame(width: 324, height: 218)
        }
    }
}

#Preview {
    LocbookActionsView()
}
