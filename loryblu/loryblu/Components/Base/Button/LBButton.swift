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
        case cancel
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
                .foregroundColor(getForegroundColor(btnStyle: style))
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(getBackgroundColor(btnStyle: style))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: -1)
                        .stroke(getStrokeColor(btnStyle: style)))
        }
    }
}

extension LBButton {
    func getForegroundColor(btnStyle: ButtonStyle) -> Color {
        switch btnStyle {
        case .primaryActivated:
            LBColor.background
        case .primaryOff:
            LBColor.buttonPrimary
        case .error:
            LBColor.error
        case .cancel:
            LBColor.text
        }
    }

    func getBackgroundColor(btnStyle: ButtonStyle) -> Color {
        switch btnStyle {
        case .primaryActivated:
            LBColor.buttonPrimary
        default:
            LBColor.background
        }
    }

    func getStrokeColor(btnStyle: ButtonStyle) -> Color {
        switch btnStyle {
        case .primaryActivated:
            LBColor.background
        case .primaryOff:
            LBColor.buttonPrimary
        case .error:
            LBColor.error
        case .cancel:
            .clear
        }
    }
}

#Preview {
    VStack {
        LBButton(title: "excluir", style: .error) {
            print("Botao de Excluir clicado")
        }
        HStack {
            LBButton(title: "Desabilitado", style: .primaryOff) {
                print("Botao de PrimaryOff clicado")
            }
            LBButton(title: "Off", style: .primaryOff) {
                print("Botao de PrimaryOff clicado")
            }
        }
        LBButton(title: "Cancelar", style: .cancel) {
            print("Botao de Cancel clicado")
        }
        LBButton(title: "Ativo", style: .primaryActivated) {
            print("Botao de PrimaryActivated clicado")
        }
    }
    .frame(height: 300)
    .background(Color.purple.opacity(0.2))
}
