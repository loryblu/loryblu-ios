//
//  HomeView.swift
//  LoryBlu
//
//  Created by Suh on 03/11/23.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedCard: Int?
    let name: String = "Bia"
    let traills: [ImageLabel] = [
        ImageLabel(image: LBIcon.locbook.rawValue, name: LBStrings.Locbook.NameImage.loryRotine, font: LBFont.titleAction, segment: .home),
        ImageLabel(image: LBIcon.fairyShadow.rawValue, name: LBStrings.Locbook.NameImage.loryRotine, font: LBFont.titleAction, segment: .home),
        ImageLabel(image: LBIcon.gamesShadow.rawValue, name: LBStrings.Locbook.NameImage.loryRotine, font: LBFont.titleAction, segment: .home)
    ]

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
                    ForEach(0..<traills.count) { index in
                        traills[index]
                            .overlay(selectedCard == index ?
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0)
                                    .strokeBorder(LBColor.borderImagetrails, lineWidth: 4) : nil
                                )

                            .opacity(selectedCard == index ? 1.0 : 0.5)
                            .onTapGesture {
                                selectedCard = index
                            }
                    }

                }
                .frame(width: 312, height: 218)

            }.padding(24)
        }
    }
}


extension HomeView {
    static func build() -> Self {
        HomeView()
    }
}

#Preview {
    HomeView()
}
