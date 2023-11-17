//
//  HomeView.swift
//  LoryBlu
//
//  Created by Suh on 03/11/23.
//

import SwiftUI

struct HomeView: View {
    let name: String = "Bia"
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                LBIcon.headMenu.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 62, height: 62)

                Text("Olá, \(name)")
                    .font(LBFont.head5)
                    .foregroundStyle(LBColor.text)
            }
            .padding(.init(top: 12, leading: 0, bottom: 32, trailing: 0))

            trails

        }
    }

    var trails: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 24) {
                Group {
                    ImageLabel(image: LBIcon.locbook.rawValue, name: LBStrings.Locbook.NameImage.loryRotine, backImage: LBColor.backgroundImagetrails, font: LBFont.titleAction)


                    ImageLabel(image: LBIcon.fairyShodow.rawValue, name: LBStrings.Locbook.NameImage.loryRotine, backImage: LBColor.backgroundImagetrails, font: LBFont.titleAction)
                        .opacity(0.5)

                    ImageLabel(image: LBIcon.tvgameShadow.rawValue, name: LBStrings.Locbook.NameImage.loryRotine, backImage: LBColor.backgroundImagetrails, font: LBFont.titleAction)
                        .opacity(0.5)
                }
                .frame(width: 312, height: 218)

            }.padding(24)
        }
    }
}

#Preview {
    HomeView()
}
