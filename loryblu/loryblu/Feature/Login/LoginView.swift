import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var isEmailValid: Bool = true
    @State var isPasswordNotEmpty: Bool = true
    @State private var rememberMe = false
    @State private var isPasswordHidden: Bool = true
    @State private var textError = ""

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
        VStack {
            LBIcon.logo.image
                .resizable()
                .frame(width: 187, height: 47)
                .padding(.bottom, 30)
                .padding(.top, 30)
            Text("Login")
                .font(LBFont.head6)
                .padding(.bottom, 22)
            VStack {
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

            VStack {

                    Text(textError)
                        .font(LBFont.caption)
                        .foregroundColor(LBColor.error)
                HStack {
                    Toggle("", isOn: $rememberMe)
                        .padding(.trailing, 18.0)
                        .labelsHidden()
                        .tint(LBColor.buttonPrimary)

                    Text(LBStrings.Login.remeber)
                        .font(LBFont.subtitle)
                        .multilineTextAlignment(.trailing)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 77, alignment: .trailing)

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
            .padding(.top, 30.0)

            HStack {
                Button(LBStrings.Login.forgotPassword) {

                }
                .font(LBFont.bodySmall)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .background(
                    LBColor.text
                    .frame(height: 1)
                    .offset(y: 14)
                )
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            ExternalLogin()
                .padding(.top, 53.0)

            HStack {
                Button(LBStrings.Login.dontHaveAccount) {

                }
                .font(LBFont.caption)
                .foregroundColor(LBColor.placeholder)
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 8)

                Button(LBStrings.Login.registerNow) {

                }
                .font(LBFont.caption)
                .foregroundColor(LBColor.buttonPrimary)
                .multilineTextAlignment(.trailing)

            }.padding(.top, 32.0)
        }
        .padding(24)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
