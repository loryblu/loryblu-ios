import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var isEmailValid: Bool = true
    @State var isPasswordNotEmpty: Bool = true
    @State private var rememberMe: Bool = false
    @State private var isPasswordHidden: Bool = true
    @State private var textError = ""

    @State private var showResetPassword: Bool = false
    @State private var showRegister: Bool = false
    @State private var path = NavigationPath()

    func tryLogin() {
        if !ValidateRules.validate(email: email) {
            isEmailValid = false
            isPasswordNotEmpty = true
            textError =  LBStrings.Login.emailNotExists
        } else if password.isEmpty {
            textError = LBStrings.Login.requiredField
            isEmailValid = true
            isPasswordNotEmpty = false
        } else if !password.isEmpty {
            textError = ""
            isPasswordNotEmpty = true
        }
        if !password.isEmpty && ValidateRules.validate(email: email) {
            textError = ""
            isPasswordNotEmpty = true
            isEmailValid = true
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                LBIcon.logo.image
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
                        text: $email,
                        textFiledState: isEmailValid ? .active : .alert)
                    .textInputAutocapitalization(.never)

                    LBTextField(
                        style: .password,
                        icon: LBIcon.lock,
                        title: LBStrings.Login.password,
                        text: $password,
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

                LBButton(title: LBStrings.Login.enter, action: tryLogin)
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
                        showResetPassword.toggle()
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

                HStack {
                    Text(LBStrings.Login.dontHaveAccount)
                        .font(LBFont.caption)
                        .foregroundColor(LBColor.placeholder)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 8)

                    Button(LBStrings.Login.registerNow) {
                        showRegister.toggle()
                    }
                    .font(LBFont.caption)
                    .foregroundColor(LBColor.buttonPrimary)
                    .multilineTextAlignment(.trailing)

                }.padding(.top, 32.0)
            }
            .padding(24)
            .navigationDestination(isPresented: $showRegister) {
                RegisterResponsibleView(path: $path)
            }
            .navigationDestination(isPresented: $showResetPassword) {
                ResetPasswordScreen(model: ResetPasswordModel())
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
