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
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func passwordValidator(_ senha: String) -> Bool {
        let passwordFormat = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: senha)
    }

    @State var email: String = ""
    @State var password: String = ""
    @State private var isEmailValid: Bool = true
    @State var isPasswordValid: Bool = true
    @State private var rememberMe = false
    @State private var isPasswordHidden: Bool = true
   
    func tryLogin(){
        if self.emailValidator(email) {
                            isEmailValid = true
                        } else {
                            isEmailValid = false
                        }
        if self.passwordValidator(password){
            isPasswordValid = true
        } else {
            isPasswordValid = false
        }
    }
    
    var body: some View {
        VStack{
            Icon.logo.image
                .resizable()
                .frame(width: 187, height: 47)
                .padding(.bottom, 40)
            Text("Login")
                .font(Style.Typography.head6)
                .padding(.bottom, 32)
            VStack{
                CustomTextField(
                    style: .common,
                    icon: Icon.mail,
                    title: "Email",
                    text :$email,
                    isHidden: .constant(true),
                    textFiledState: !isEmailValid ? .alert : .active)
                .textInputAutocapitalization(.never)
                
                CustomTextField(
                    style: .password,
                    icon: Icon.lock,
                    title: "Senha",
                    text:$password,
                   isHidden: $isPasswordHidden,
                    textFiledState: isPasswordValid ? .active : .alert)
                .textInputAutocapitalization(.never)
            }
            
            VStack{
              
                if !isEmailValid {
                    Text("* Email inválido").font(Style.Typography.caption).foregroundColor(.red)}
                
                if !isPasswordValid {
                    Text("* Senha inválida").font(Style.Typography.caption).foregroundColor(.red)}
                
                HStack{
                    Toggle("Agree", isOn: $rememberMe).padding(.trailing, 18.0).labelsHidden()
                    Text("Lembrar").font(Style.Typography.subtitle).multilineTextAlignment(.trailing)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 77, alignment: .trailing)
            
            Buttons(title: "entrar", action: tryLogin)
                .padding(.top, 51)
            
            HStack {
                VStack { Divider().background(Style.ColorPalette.text) }.padding(20)
                Text("ou").foregroundColor(Style.ColorPalette.text)
                VStack { Divider().background(Style.ColorPalette.text) }.padding(20)
                    }
            .padding(.top, 30.0)
            
            HStack{
                
                Button("Esqueceu sua senha?"){}.font(Style.Typography.bodySmall).foregroundColor(.black).multilineTextAlignment(.trailing).background(
                    Style.ColorPalette.text
                    .frame(height: 1)
                        .offset(y: 14))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            ExternalLogin()
                .padding(.top, 53.0)
            
            HStack{
                
                Button("Não tem uma conta?"){}.font(Style.Typography.caption).foregroundColor(Style.ColorPalette.placeholder).multilineTextAlignment(.trailing).padding(.trailing, 8)
                
                Button("Registrar agora"){}.font(Style.Typography.caption).foregroundColor(Style.ColorPalette.buttonPrimary).multilineTextAlignment(.trailing)
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