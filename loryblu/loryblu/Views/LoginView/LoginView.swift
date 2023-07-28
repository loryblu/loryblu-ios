//
//  LoginView.swift
//  LoryBlu
//
//  Created by Paulo Pinheiro on 7/25/23.
//

import SwiftUI

struct LoginView: View {
    
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" )
    
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "ˆ(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z].{8,}$")
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State private var rememberMe = false
    
    
    
    func sendLogin(){
        //your logic here
    }
    var body: some View {
        VStack{
            Image("loryblu_logo")
                .padding(.bottom, 40)
            Text("Login")
                .font(Style.Typography.head6)
                .padding(.bottom, 32)
            VStack{
                CustomTextField(
                    style: .common,
                    icon: Icon.mail,
                    title: "Email",
                    text:$email,
                    isHidden: .constant(true),
                    textFiledState: .active)
                
                CustomTextField(
                    style: .password,
                    icon: Icon.lock,
                    title: "Senha",
                    text:$password,
                    isHidden: .constant(false),
                    textFiledState: .active)
                
            }
            
            VStack{
                if emailPredicate.evaluate(with: email) && !email.isEmpty {
                    Text("Email inválido")}
                
                HStack{
                    
                    Toggle("Agree", isOn: $rememberMe).padding(.trailing, 18.0).labelsHidden()
                    Text("Lembrar").font(Style.Typography.subtitle).multilineTextAlignment(.trailing)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 77, alignment: .trailing)
            
            
            Buttons(title: "entrar", action: sendLogin).padding(.horizontal, 24)
                .padding(.top, 51)
            
            LabelledDivider(label:  "ou").padding(.top, 30.0)
            
            HStack{
                
                Button("Esqueceu sua senha?"){}.font(Style.Typography.bodySmall).foregroundColor(.black).multilineTextAlignment(.trailing).background(
                    Color.black
                    .frame(height: 1)
                        .offset(y: 14)
                        
                )
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
