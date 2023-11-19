import SwiftUI

struct LoginView: View {
    
    @State private var isEmailValid: Bool = true
    @State private var isPasswordNotEmpty: Bool = true
    @State private var rememberMe: Bool = false
    @State private var isPasswordHidden: Bool = true
    @State private var textError = ""

    @State private var showResetPassword: Bool = false

    @State private var showResponsibleRegister: Bool = false
    @State private var showChildRegister: Bool = false

    @StateObject var model: LoginModel
    @EnvironmentObject var coordinator: LoginNavigationStack.NavigationCoordinator

    @MainActor func tryLogin() {
        if !ValidateRules.validate(email: model.email) {
            isEmailValid = false
            isPasswordNotEmpty = true
            textError =  LBStrings.Login.emailNotExists
        } else if model.password.isEmpty {
            textError = LBStrings.Login.requiredField
            isEmailValid = true
            isPasswordNotEmpty = false
        } else if !model.password.isEmpty {
            textError = ""
            isPasswordNotEmpty = true
        }
        if !model.password.isEmpty && ValidateRules.validate(email: model.email) {
            textError = ""
            isPasswordNotEmpty = true
            isEmailValid = true
        }

        model.authenticate()
    }

    var body: some View {
        VStack {
            LBIcon.logoName.image
                .resizable()
                .frame(width: 187, height: 47)
                .padding(.bottom, 30)
                .padding(.top, 30)
            Text(LBStrings.Login.title)
                .font(LBFont.head6)
                .padding(.bottom, 22)

            VStack(spacing: 16) {
                LBTextField(
                    style: .common,
                    icon: LBIcon.mail,
                    title: LBStrings.Login.email,
                    text: $model.email,
                    textFiledState: isEmailValid ? .active : .alert)
                .textInputAutocapitalization(.never)

                LBTextField(
                    style: .password,
                    icon: LBIcon.lock,
                    title: LBStrings.Login.password,
                    text: $model.password,
                    textFiledState: isPasswordNotEmpty ? .active : .alert)
                .textInputAutocapitalization(.never)
            }

            VStack(alignment: .trailing) {
                Text(textError)
                    .font(LBFont.caption)
                    .foregroundColor(LBColor.error)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                HStack {
                    LBToggle(isActived: $rememberMe)
                    // Metodo pra deixar a senha salva
                    Text(LBStrings.Login.remeber)
                        .font(LBFont.caption)
                        .multilineTextAlignment(.trailing)
                }
            }.padding(.top, 10)

            if model.status == .fail {
                Text("Login falhou. 😰")
            } else if model.status == .success {
                Text("Deu bom hein...... ☺️")
            }

            LBButton(
                title: LBStrings.Login.enter,
                action: {
                self.tryLogin()
            })
                .padding(.top, 51)

            HStack {
                VStack {
                    Divider()
                        .background(LBColor.text)

                }.padding(20)

                Text(LBStrings.Login.orDivider)
                    .foregroundColor(LBColor.text)

                VStack {
                    Divider()
                        .background(LBColor.text)
                }.padding(20)
            }
            .padding(.top, 28)

            HStack {
                Button {
                    coordinator.openResetPassword()
                } label: {
                    Text(LBStrings.Login.forgotPassword)
                        .font(LBFont.bodySmall)
                        .underline()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing)
                }

            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            ExternalLogin()
                .padding(.top, 53.0)
                .padding(.bottom, 24)

            HStack {
                Text(LBStrings.Login.dontHaveAccount)
                    .font(LBFont.caption)
                    .foregroundColor(LBColor.placeholder)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 8)

                Button(LBStrings.Login.registerNow) {
                    coordinator.openRegister()
                }
                .font(LBFont.caption)
                .foregroundColor(LBColor.buttonPrimary)
                .multilineTextAlignment(.trailing)

            }.padding(.bottom, 32.0)
        }
        .padding(24)
    }
}


// MARK: - Factory
extension LoginView {
    static func build() -> LoginView {
        LoginView(model: LoginModel())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView.build()
    }
}
