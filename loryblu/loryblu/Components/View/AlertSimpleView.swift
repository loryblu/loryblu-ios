import SwiftUI

struct AlertSimpleView: View {
    let text: String
    let subText: String
    let icon: LBIcon
    let textColor: Color
    let borderColor: Color

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(icon.rawValue)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.top, 2)
            Text(text)
                .foregroundColor(textColor)
                .font(LBFont.bodySmall) +
            Text(subText)
                .foregroundColor(LBColor.titlePrimary)
                .font(LBFont.buttonSmall)
                .underline()
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 40)
        .padding(.init(top: 8, leading: 12, bottom: 8, trailing: 0))
        .overlay(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            ).stroke(borderColor, lineWidth: 1)
        )
    }
}

#Preview {
    AlertSimpleView(
        text: "Ações bloqueadas! Você pode alterar as permissões em ",
        subText: "Controle de Acesso.",
        icon: .check,
        textColor: LBColor.titlePrimary,
        borderColor: LBColor.titlePrimary
    )
}
