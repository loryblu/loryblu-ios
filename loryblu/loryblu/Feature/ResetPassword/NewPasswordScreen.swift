import SwiftUI

struct NewPasswordScreen: View {
    @ObservedObject var model: NewPasswordModel
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var coordinator: LoginNavigationStack.NavigationCoordinator

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            LBIcon.logoName.image
                .frame(width: 187, height: 47)
                .padding(40)
            Text(LBStrings.SetPassword.create)
                .font(LBFont.titleTask)
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
                PasswordRulesView(password: model.password)
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
                    Task {
                        await model.setPassword(newPassword: model.confirmPassword, token: appData.token)
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .fullScreenCover(isPresented: $model.goToLogin) {
            switch model.state {
            case .success:
                DoneView(
                    props: .init(
                        message: LBStrings.SetPassword.successChangePassword,
                        onClose: { dismiss() }
                    )
                )
            case .failure:
                DoneView(
                    props: .init(
                        message: LBStrings.SetPassword.failureChangePassword,
                        onClose: { dismiss() }
                    )
                )
            }
        }
    }
}

extension NewPasswordScreen {
    static func build() -> Self {
        NewPasswordScreen(model: NewPasswordModel())
    }
}


struct NewPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var appData: AppData = .init()
        NewPasswordScreen(model: NewPasswordModel())
            .environmentObject(appData)
    }
}
