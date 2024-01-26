//
//  ImageLogbook.swift
//  LoryBlu
//
//  Created by Suh on 24/10/23.
//

import SwiftUI

struct ImageLogbook: View {
    var image: String
    var backcolor: Color

    var body: some View {
        Rectangle()
            .frame(width: 200, height: 200)
            .background(
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .foregroundStyle(backcolor)
    }
}

#Preview {
    ImageLogbook(image: LBIcon.dailyList.rawValue, backcolor: .clear)
}
