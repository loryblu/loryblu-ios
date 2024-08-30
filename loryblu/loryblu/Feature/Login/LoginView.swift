import SwiftUI

struct LoginView: View {
    @State private var form = FormConfig()
    @StateObject var model: LoginModel
    @EnvironmentObject var coordinator: LoginNavigationStack.NavigationCoordinator

    @MainActor func tryLogin() {
        if form.validateLogin() {
            model.authenticate(email: form.email, password: form.password)
        }
    }

    func updateStatusLogin() {
        if model.loginStatus == .fail {
            form.textError = model.networkError
        }
    }

    var body: some View {
        GeometryReader { _ in
            VStack {
                LBIcon.logoName.image
                    .resizable()
                    .frame(width: 187, height: 47)
                    .padding(.bottom, 30)
                    .padding(.top, 30)
                Text(LBStrings.Login.title)
                    .font(LBFont.titleTask)
                    .padding(.bottom, 22)

                VStack(spacing: 16) {
                    LBTextField(
                        style: .common,
                        icon: LBIcon.mail,
                        title: LBStrings.Login.email,
                        text: $form.email,
                        textFiledState: form.isEmailValid ? .active : .alert)
                    .textInputAutocapitalization(.never)

                    LBTextField(
                        style: .password,
                        icon: LBIcon.lock,
                        title: LBStrings.Login.password,
                        text: $form.password,
                        textFiledState: form.isPasswordNotEmpty ? .active : .alert)
                    .textInputAutocapitalization(.never)
                }

                VStack(alignment: .trailing) {
                    Text(form.textError)
                        .font(LBFont.caption)
                        .foregroundColor(LBColor.error)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    HStack {
                        LBToggle(isActived: $form.rememberMe)
                        // Metodo pra deixar a senha salva
                        Text(LBStrings.Login.remeber)
                            .font(LBFont.caption)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.top, 10)

                LBButton(title: LBStrings.Login.enter) {
                    self.tryLogin()
                }
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
                        coordinator.showResetPassword()
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
                        coordinator.showRegister()
                    }
                    .font(LBFont.caption)
                    .foregroundColor(LBColor.buttonPrimary)
                    .multilineTextAlignment(.trailing)

                }.padding(.bottom, 32.0)
            }
            .padding(24)
            .onChange(of: model.loginStatus) { newValue in
                if newValue == .fail {
                    updateStatusLogin()
                }
            }
        }
    }
}

extension LoginView {
    struct FormConfig {
        var email: String = ""
        var password: String = ""
        var isEmailValid: Bool = true
        var isPasswordNotEmpty: Bool = true
        var rememberMe: Bool = false
        var isPasswordHidden: Bool = true
        var textError = ""
        var showResetPassword: Bool = false
        var showResponsibleRegister: Bool = false
        var showChildRegister: Bool = false

        mutating func validateLogin() -> Bool {
            if !ValidateRules.validate(email: email) {
                isEmailValid = false
                isPasswordNotEmpty = true
                textError =  LBStrings.Login.emailNotExists
                return false
            }

            if password.isEmpty {
                textError = LBStrings.Login.requiredField
                isEmailValid = true
                isPasswordNotEmpty = false
                return false
            }

            isEmailValid = true
            textError = ""
            isPasswordNotEmpty = true
            return true
        }
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
