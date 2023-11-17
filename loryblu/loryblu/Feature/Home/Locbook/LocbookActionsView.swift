//
//  LocbookActionsView.swift
//  LoryBlu
//
//  Created by Suh on 06/11/23.
//

import SwiftUI

struct LocbookActionsView: View {
    @State private var selectedCard: Int?
    typealias Localizable = LBStrings.Locbook
    let options: [ImageLabel] = [
        ImageLabel(image: LBIcon.dailyStudy.rawValue, name: Localizable.NameImage.loryStudy, font: LBFont.titleAction, segment: .locbook),
        ImageLabel(image: LBIcon.dailyRotine.rawValue, name: Localizable.NameImage.loryRotine, font: LBFont.titleAction, segment: .locbook)
    ]

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack {
                Text("<")
                Text(Localizable.title)
                    .font(LBFont.titleAction)
                .foregroundStyle(LBColor.titlePrimary)

                Spacer()
            }

            LBIcon.progression1.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, minHeight: 40)

            HStack {
                Text(LBStrings.Locbook.actionTitle)
                    .font(LBFont.buttonSmall)
                .foregroundStyle(LBColor.titlePrimary)
                Spacer()
            }

            actions

            LBButton(
                title: Localizable.button,
                style: .primaryActivated) {
                    //
                }
                .padding(.top, 15)
        }
        .padding(24)

    }

    var actions: some View {
        VStack(spacing: 24) {
            Group {
                ForEach(0..<options.count) { index in
                    options[index]
                        .overlay(selectedCard == index ?
                                 RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0)
                            .strokeBorder(LBColor.titlePrimary, lineWidth: 4) : nil
                        )
                        .opacity(selectedCard == index ? 1.0 : 0.5)
                        .onTapGesture {
                            selectedCard = index
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 218)
        }
    }
}

#Preview {
    LocbookActionsView()
}
