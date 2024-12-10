import SwiftUI

struct AlertSimpleView: View {
    let text: String
    let icon: String
    let textColor: Color
    let borderColor: Color

    var body: some View {
        HStack(alignment: .center) {
            Image(icon)
            Text(text)
                .foregroundStyle(textColor)
                .font(LBFont.bodySmall)

        }
        .padding(8)
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
