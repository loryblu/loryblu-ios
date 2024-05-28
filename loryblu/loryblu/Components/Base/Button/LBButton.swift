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
        case error
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
                .foregroundColor(getForegroundColor(btnStyle:style))
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(getBackgroundColor(btnStyle: style))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: -1)
                        .stroke(getStrokeColor(btnStyle:style)))
        }
    }
}

extension LBButton {
    func getForegroundColor(btnStyle: ButtonStyle) -> Color {
        switch btnStyle {
        case .primaryActivated:
                .white
        case .primaryOff:
            LBColor.buttonPrimary
        case .error:
            LBColor.error
        }
    }
    
    func getBackgroundColor(btnStyle: ButtonStyle) -> Color {
        switch btnStyle {
        case .primaryActivated:
            LBColor.buttonPrimary
        case .primaryOff:
             .white
        case .error:
            Color.clear
        }
    }
    
    func getStrokeColor(btnStyle: ButtonStyle) -> Color {
        switch btnStyle {
        case .primaryActivated:
                .white
        case .primaryOff:
            LBColor.buttonPrimary
        case .error:
            LBColor.error
        }
    }
}
