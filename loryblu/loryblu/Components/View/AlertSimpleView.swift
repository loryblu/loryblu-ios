import SwiftUI

struct AlertSimpleView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(LBIcon.check.rawValue)
            
            Text("Sua conta será desconectada e você \nprecisará entrar com sua nova senha.")
                .foregroundStyle(LBColor.titlePrimary)
                .font(LBFont.bodySmall)

        }
        .padding(8)
        .overlay(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            ).stroke(LBColor.titlePrimary, lineWidth: 1)
        )
    }
}

#Preview {
    AlertSimpleView()
}
