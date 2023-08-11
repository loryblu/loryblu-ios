import SwiftUI

struct NewPasswordScreen: View {
    @State var newPassword: String = ""
    @State var repeatNewPassword: String = ""
    var body: some View {
        VStack {
            LBIcon.logo.image
                .frame(width: 187, height: 47)
                .padding(40)
            Text(LBStrings.SetPassword.create)
                .font(LBFont.head6)
                .padding(24)
            Text(LBStrings.SetPassword.reset)
                .font(LBFont.bodySmall)
                .padding(.bottom, 56)

            LBTextField(style: .password,
                        icon: .lock,
                        title: LBStrings.SetPassword.newPassword,
                        text: $newPassword,
                        textFiledState: .active)
            .padding(.bottom, 12)

            HStack {
                PasswordRulesView(password: newPassword)
                Spacer()
            }.padding(.bottom, 16)

            LBTextField(style: .password,
                        icon: .lock,
                        title: LBStrings.SetPassword.repeatPassword,
                        text: $repeatNewPassword,
                        textFiledState: .active)
            .padding(.bottom, 32)

            Text(LBStrings.SetPassword.alert)
                .font(LBFont.bodyLittleSmall)
                .foregroundColor(LBColor.text)
                .padding(.bottom, 40)

            LBButton(title: LBStrings.SetPassword.buttonReset) {
                // receber função do backend
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
