//
//  ImageLabel.swift
//  LoryBlu
//
//  Created by Suh on 23/10/23.
//

import SwiftUI

struct ImageLabel: View {
    let image: String
    let name: String
    let backImage: Color
    let borderImage: Color
    let font: Font

    var body: some View {
        VStack {
            Spacer()
            GeometryReader { proxy in
                let size = min(proxy.size.width, proxy.size.height)

                VStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            Text(name)
                .multilineTextAlignment(.center)
                .font(font)
                .foregroundStyle(LBColor.background)
                .frame(maxWidth: .infinity, minHeight: 45)
                .background(borderImage)

        }
        .background(backImage)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12)
            .inset(by: 2)
            .stroke(borderImage, lineWidth: 4)
        )
    }
}

#Preview {
    ImageLabel(image: LBIcon.dailyRotine.rawValue, name: LBStrings.Locbook.NameImage.therapist, backImage: LBColor.backgroundImagetrails, borderImage: LBColor.borderImagetrails, font: LBFont.titleAction)
}
