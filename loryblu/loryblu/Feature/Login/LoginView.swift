//
//  LoginView.swift
//  LoryBlu
//
//  Created by Paulo Pinheiro on 7/25/23.
//

import SwiftUI

struct LoginView: View {

    func emailValidator(_ email: String) -> Bool {
        if email.count > 100 {
            return false
        }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }

    func passwordValidator(_ senha: String) -> Bool {
        let passwordFormat = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: senha)
    }

    @State var email: String = ""
    @State var password: String = ""
    @State private var isEmailValid: Bool = true
    @State var isPasswordValid: Bool = true
    @State private var rememberMe = false
    @State private var isPasswordHidden: Bool = true

    func tryLogin() {
        if self.emailValidator(email) {
            isEmailValid = true
        } else {
            isEmailValid = false
        }
        if self.passwordValidator(password) {
            isPasswordValid = true
        } else {
            isPasswordValid = false
        }
    }

    var body: some View {
        VStack {
            LBIcon.logo.image
                .resizable()
                .frame(width: 187, height: 47)
                .padding(.bottom, 40)
            Text("Login")
                .font(LBFont.head6)
                .padding(.bottom, 32)
            VStack {
                LBTextField(
                    style: .common,
                    icon: LBIcon.mail,
                    title: "Email",
                    text: $email,
                    textFiledState: !isEmailValid ? .alert : .active)
                .textInputAutocapitalization(.never)

                LBTextField(
                    style: .password,
                    icon: LBIcon.lock,
                    title: "Senha",
                    text: $password,
                    textFiledState: isPasswordValid ? .active : .alert)
                .textInputAutocapitalization(.never)
            }

            VStack {

                if !isEmailValid {
                    Text("* Email inválido").font(LBFont.caption).foregroundColor(.red)}

                if !isPasswordValid {
                    Text("* Senha inválida").font(LBFont.caption).foregroundColor(.red)}

                HStack {
                    Toggle("Agree", isOn: $rememberMe)
                        .padding(.trailing, 18.0)
                        .labelsHidden()
                        .tint(LBColor.buttonPrimary)

                    Text("Lembrar")
                        .font(LBFont.subtitle)
                        .multilineTextAlignment(.trailing)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 77, alignment: .trailing)

            LBButton(title: "entrar", action: tryLogin)
                .padding(.top, 51)

            HStack {
                VStack { Divider().background(LBColor.text) }.padding(20)
                Text("ou").foregroundColor(LBColor.text)
                VStack { Divider().background(LBColor.text) }.padding(20)
                    }
            .padding(.top, 30.0)

            HStack {

                Button("Esqueceu sua senha?") {

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

                Button("Não tem uma conta?") {

                }
                .font(LBFont.caption)
                .foregroundColor(LBColor.placeholder)
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 8)

                Button("Registrar agora") {

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
