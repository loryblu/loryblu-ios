import SwiftUI

struct SetPassword {
    var password: String
    var recoveryToken: String
}

struct NewPasswordScreen: View {
    @EnvironmentObject var model: NewPasswordModel
    @State var token: SetPassword
    @State var newPassword: String = ""
    @State var confirmNewPassword: String = ""
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
                        text: $model.password,
                        textFiledState: .active)
            .padding(.bottom, 12)

            HStack {
                PasswordRulesView(password: newPassword)
                Spacer()
            }.padding(.bottom, 16)

            LBTextField(style: .password,
                        icon: .lock,
                        title: LBStrings.SetPassword.repeatPassword,
                        text: $model.confirmPassword,
                        textFiledState: .active)
            .padding(.bottom, 10)

            VStack(spacing: 5) {

                if model.isEqual == true {
                    Text("")
                    .padding()
                } else {
                    Text(LBStrings.SetPassword.passwordMustbeEqual)
                        .font(LBFont.caption)
                        .foregroundColor(LBColor.error)
                        .padding(.bottom)
                }
                  Text(LBStrings.SetPassword.alert)
                    .font(LBFont.bodyLittleSmall)
                    .foregroundColor(LBColor.text)
                .padding(.bottom)
            }

            LBButton(title: LBStrings.SetPassword.buttonReset) {
                // receber função do backend
                model.showError()
                if model.isEqual {
                    token.password = model.confirmPassword
                    model.setPassword(setPassword: token)
                }

            }

        }
        .padding(.horizontal, 24)

    }
}

struct NewPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        @State var setPassword: SetPassword = SetPassword(password: "NewPassword", recoveryToken: "token")
        NewPasswordScreen(token: setPassword).environmentObject(NewPasswordModel())
    }
}
