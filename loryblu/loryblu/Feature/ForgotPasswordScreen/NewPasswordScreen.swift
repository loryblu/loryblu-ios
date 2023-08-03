import SwiftUI

struct NewPasswordScreen: View {
    //    @State var check: CheckdeRules = CheckdeRules()
    @State var newPassword: String = ""
    @State var repeatNewPassword: String = ""
    var body: some View {
        VStack {
            LBIcon.logo.image
                .frame(width: 187, height: 47)
                .padding(40)
            Text("Criar nova senha")
                .font(LBFont.head6)
                .padding(24)
            Text("Redefina sua senha aqui")
                .font(LBFont.bodySmall)
                .padding(.bottom, 56)

            LBTextField(style: .password,
                        icon: .lock,
                        title: "Nova senha",
                        text: $newPassword,
                        textFiledState: .active)
            .padding(.bottom, 12)

            HStack {
                PasswordRulesView(password: newPassword)
                Spacer()
            }.padding(.bottom, 16)

            LBTextField(style: .password,
                        icon: .lock,
                        title: "Repetir senha",
                        text: $repeatNewPassword,
                        textFiledState: .active)
            .padding(.bottom, 32)

            Text(LBStrings.SetPassword.alert)
                .font(LBFont.bodyLittleSmall)
                .foregroundColor(LBColor.text)
                .padding(.bottom, 40)

            LBButton(title: "REDEFINIR SENHA") {
                // receber função dp backend
            }

        }
        .padding(.horizontal, 24)

    }
}

struct NewPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordScreen()
    }
}
