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
                .foregroundStyle(LBColor.borderSelectLogbook)

            Text(LBStrings.Locbook.actionTitle)
                .font(LBFont.buttonSmall)
                .foregroundStyle(LBColor.borderSelectLogbook)

            actions

            LBButton(
                title: Localizable.button,
                style: .primaryActivated) {
                    //
                }
                .frame(width: 200)
                .padding(.top, 15)
        }
        .padding(.init(top: 15, leading: 0, bottom: 50, trailing: 0))
    }

    var actions: some View {
        VStack(spacing: 24) {
            Group {
                ImageLabel(image: LBIcon.dailyStudy.rawValue, name: Localizable.NameImage.loryStudy, backImage: LBColor.backgroundCards, borderImage: LBColor.borderImageLogbook, font: LBFont.titleAction)

                ImageLabel(image: LBIcon.dailyRotine.rawValue, name: Localizable.NameImage.loryRotine, backImage: LBColor.backgroundCards, borderImage: LBColor.borderImageLogbook, font: LBFont.titleAction)
            }
            .frame(width: 324, height: 218)
        }
    }
}

#Preview {
    LocbookActionsView()
}
