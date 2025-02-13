import Foundation
import SwiftUI

struct LBButton: View {
    init(
        title: String,
        style: ButtonStyle = .primaryActivated,
        isUppercased: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = LBButton.formatTitle(title, isUppercased: isUppercased)
        self.style = style
        self.action =  action
    }

    enum ButtonStyle {
        case primaryActivated
        case primaryOff
        case error
        case cancel
    }

    let title: String
    var style: ButtonStyle
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(getFont(btnStyle: style))
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
    private func getForegroundColor(btnStyle: ButtonStyle) -> Color {
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

    private func getBackgroundColor(btnStyle: ButtonStyle) -> Color {
        btnStyle == .primaryActivated ? LBColor.buttonPrimary : .clear
    }

    private func getStrokeColor(btnStyle: ButtonStyle) -> Color {
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

    private func getFont(btnStyle: ButtonStyle) -> Font {
        btnStyle == .cancel ? LBFont.body : LBFont.button
    }

    private static func formatTitle(_ text: String, isUppercased: Bool) -> String {
        isUppercased ? text.uppercased() : text.prefix(1).uppercased() + text.dropFirst().lowercased()
    }
}

#Preview {
    VStack {
        LBButton(title: "excluir", style: .error) {
            print("Botao de Excluir clicado")
        }
        HStack {
            LBButton(title: "Desabilitado", style: .primaryOff, isUppercased: false) {
                print("Botao de PrimaryOff clicado")
            }
            LBButton(title: "Off", style: .primaryOff) {
                print("Botao de PrimaryOff clicado")
            }
        }
        LBButton(title: "CANCELAR", style: .cancel, isUppercased: false) {
            print("Botao de Cancel clicado")
        }
        LBButton(title: "Ativo", style: .primaryActivated) {
            print("Botao de PrimaryActivated clicado")
        }
    }
    .frame(height: 300)
    .background(Color.purple.opacity(0.2))
}
