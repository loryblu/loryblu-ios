import SwiftUI

struct NewPasswordScreen: View {
    enum PasswordRequirements: String {
        case containsSize = "Pelo menos 8 caracteres"
        case containsUppercase = "Pelo menos uma letra maiúscula"
        case containsLowercase = "Letras minúsculas"
        case containsNumber = "Números"
        case containsSpecial = "Pelo menos um caractere especial: ! @ # $ % *"

        var requirements: String {
            String(self.rawValue)
        }

    }
    @Binding var userEmail: String
    @Binding var isHidden: Bool
    @State var passwordRequirements: PasswordRequirements
    var body: some View {
        VStack {
            Image("logo")
                .frame(width: 187, height: 47)
                .padding(40)
            Text("Criar nova senha")
                .font(Style.Typography.head6)
                .padding(24)
            Text("Redefina sua senha aqui")
                .font(Style.Typography.subtitle)

            CustomTextField(style: .password,
                            icon: Icon.lock,
                            title: "Nova senha",
                            text: $userEmail,
                            isHidden: $isHidden,
                            textFiledState: .active)
            VStack {
                HStack(spacing: 5) {
                    Image("close")
                    Text(PasswordRequirements.containsSize.requirements)
                        .font(Style.Typography.caption)
                        .foregroundColor(Style.ColorPalette.error)
                       Spacer()
                }
                HStack(spacing: 5) {
                    Image("close")
                    Text(PasswordRequirements.containsUppercase.requirements)
                        .font(Style.Typography.caption)
                        .foregroundColor(Style.ColorPalette.error)
                       Spacer()
                }
                HStack(spacing: 5) {
                    Image("close")
                    Text(PasswordRequirements.containsLowercase.requirements)
                        .font(Style.Typography.caption)
                        .foregroundColor(Style.ColorPalette.error)
                       Spacer()
                }
                HStack(spacing: 5) {
                    Image("close")
                    Text(PasswordRequirements.containsNumber.requirements)
                        .font(Style.Typography.caption)
                        .foregroundColor(Style.ColorPalette.error)
                       Spacer()
                }
                HStack(spacing: 5) {
                    Image("close")
                    Text(PasswordRequirements.containsSpecial.requirements)
                        .font(Style.Typography.caption)
                        .foregroundColor(Style.ColorPalette.error)
                       Spacer()
                }

            }
            .padding()
            CustomTextField(style: .password,
                            icon: Icon.lock,
                            title: "Repetir senha",
                            text: $userEmail,
                            isHidden: $isHidden,
                            textFiledState: .active)
        }
    }
}

struct NewPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordScreen(
            userEmail: .constant(""),
            isHidden: .constant(false),
            passwordRequirements: .containsLowercase)

    }
}
