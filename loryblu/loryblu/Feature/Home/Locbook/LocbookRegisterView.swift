//
//  LocbookRegisterView.swift
//  LoryBlu
//
//  Created by Suh on 03/11/23.
//

import SwiftUI

struct LocbookRegisterView: View {
    var body: some View {
        VStack(alignment: .center){

            Text(LBStrings.Locbook.title)
                .font(LBFont.titleAction)
                .foregroundStyle(LBColor.borderSelectLogbook)

            LBIcon.dailyList.image
                .resizable()
                .scaledToFit()
                .padding(.top, 70)

            LBButton(
                title: LBStrings.Locbook.button,
                style: .primaryActivated) {
                    //
                }
                .frame(width: 220)
                .padding(.top, 82)
        }
        .padding(.init(top: 15, leading: 26, bottom: 50, trailing: 26))
    }
}

#Preview {
    LocbookRegisterView()
}