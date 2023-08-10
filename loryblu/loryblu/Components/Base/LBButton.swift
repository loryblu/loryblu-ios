import Foundation
import SwiftUI

struct LBButton: View {
    init(title: String, style: ButtonStyle = .primaryActivated, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action =  action
    }

    enum ButtonStyle {
        case primaryActivated
        case primaryOff
    }

    var title: String
    var style: ButtonStyle
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .textCase(.uppercase)
                .font(LBFont.button)
                .multilineTextAlignment(.center)
                .foregroundColor( ((style == .primaryActivated) ? .white : LBColor.buttonPrimary))
                .frame(maxWidth: .infinity, maxHeight: 44, alignment: .center)
                .background((style == .primaryActivated) ? LBColor.buttonPrimary : LBColor.grayLight)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: -1)
                        .stroke((style == .primaryActivated) ? .white :  LBColor.grayLight))
        }
    }
}
