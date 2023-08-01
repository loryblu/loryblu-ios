//
//  LBButton.swift
//  LoryBlu
//
//  Created by Paulo Pinheiro on 7/16/23.
//

import Foundation
import SwiftUI

struct LBButton: View {

    init(title: String, style: ButtonStyle = .primary, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action =  action
    }

    enum ButtonStyle {
        case primary
        case second
    }

    var title: String
    var style: ButtonStyle
    let action: () -> Void

    var body: some View {

        Button(title) {
           action()
        }
        .textCase(.uppercase)
        .font(LBFont.button)
        .multilineTextAlignment(.center)
        .foregroundColor( ((style == .primary) ? .white : LBColor.buttonPrimary))
        .frame(maxWidth: .infinity, maxHeight: 44, alignment: .center)
        .background((style == .primary) ? LBColor.buttonPrimary : .white)
        .cornerRadius(10)
        .overlay(
        RoundedRectangle(cornerRadius: 10)
            .inset(by: -1)
            .stroke((style == .primary) ? .white :  LBColor.buttonPrimary))
    }

}
