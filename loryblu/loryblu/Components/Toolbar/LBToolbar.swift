//
//  LoryBluToolbarItem.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 28/01/24.
//
import SwiftUI

struct LBToolBarItem: ToolbarContent {
    let title: String
    let showCloseButton: Bool
    var onClose: () -> Void

    @Environment(\.presentationMode) var presentationMode

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarLeading) {
            HStack {

                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(LBIcon.arrowBack.rawValue)
                }
                .frame(alignment: .topLeading)
                .padding(.leading, 16.0)

                Text(title)
                    .font(LBFont.titleAction)
                    .foregroundStyle(LBColor.titlePrimary)
                    .padding(.leading, 8.0)

            }.padding(.top, 16.0)
        }

        ToolbarItem(placement: .topBarTrailing) {

            if showCloseButton {
                Button {
                    onClose()
                } label: {
                    Image(LBIcon.close2.rawValue)
                        .resizable()
                        .frame(width: 12, height: 12)
                }
                .frame(alignment: .topLeading)
                .padding(.trailing, 24.0)
                .padding(.top, 16.0)
            }
        }
    }
}
