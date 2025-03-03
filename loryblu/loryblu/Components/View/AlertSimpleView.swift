import SwiftUI

struct AlertSimpleView: View {
    let text: String
    let subText: String
    let icon: LBIcon
    let textColor: Color
    let borderColor: Color
    @State private var isNavigation: Bool = false
    @EnvironmentObject var coordinator: MenuNavigationStack.NavigationCoordinator

    var body: some View {
        NavigationStack {
            HStack(alignment: .top, spacing: 16) {
                Image(icon.rawValue)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.top, 2)
                    .onTapGesture {
                        isNavigation = true
                    }
                Text(text)
                    .foregroundColor(textColor)
                    .font(LBFont.bodySmall) +
                Text(subText)
                    .foregroundColor(LBColor.titlePrimary)
                    .font(LBFont.buttonSmall)
                    .underline()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 40)
        .padding(.init(top: 8, leading: 12, bottom: 8, trailing: 0))
        .overlay(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            ).stroke(borderColor, lineWidth: 1)
        )
        .navigationDestination(isPresented: $isNavigation) {
            PuzzleView {
                coordinator.pushAccessControlView(props: .init(isAvaliable: true))
            }
        }
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
