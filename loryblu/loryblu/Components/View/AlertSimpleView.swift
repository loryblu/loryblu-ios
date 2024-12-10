import SwiftUI

struct AlertSimpleView: View {
    let text: String
    let icon: String
    let textColor: Color
    let borderColor: Color

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(icon)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.top, 2)
            Text(text)
                .foregroundStyle(textColor)
                .font(LBFont.bodySmall)
                .lineLimit(2)
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
        text: LBStrings.SetPassword.logoutNewPassword,
        icon: LBIcon.check.rawValue,
        textColor: LBColor.titlePrimary,
        borderColor: LBColor.titlePrimary
    )
}
