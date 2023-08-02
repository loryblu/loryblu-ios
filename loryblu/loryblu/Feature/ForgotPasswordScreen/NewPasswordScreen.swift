import SwiftUI

struct NewPasswordScreen: View {
    @State var check: CheckdeRules = CheckdeRules()
    @State var newPassword: String = ""
    @State var repeatNewPassword: String = ""
     var body: some View {
        VStack {
            Image("logo")
                .frame(width: 187, height: 47)
                .padding(40)
            Text("Criar nova senha")
                .font(Style.Typography.head6)
                .padding(24)
            Text("Redefina sua senha aqui")
                .font(Style.Typography.bodySmall)

            CustomTextField(style: .password,
                            icon: Icon.lock,
                            title: "Nova senha",
                            text: $newPassword,
                            textFiledState: .active)

            VStack(alignment: .leading) {
                Text("A senha deve conter:")
                    .font(Style.Typography.bodyLittleSmall)
                    .foregroundColor(Style.ColorPalette.text)
                    .padding(.horizontal, 12)
                HStack {
                    CheckRulesView(type: checkRules(check.checkNumber(newPassword)),
                                   requirement: .containsSize)
                    Spacer()
                  }
                .padding(.leading)
                HStack {
                    CheckRulesView(type: checkRules(check.checkNumber(newPassword)),
                                   requirement: .containsUppercase)
                    Spacer()
                }
                .padding(.leading)
                HStack {
                    CheckRulesView(type: checkRules(check.checkLowercase(newPassword)),
                                   requirement: .containsLowercase)
                    Spacer()
                }
                .padding(.leading)
                HStack {
                    CheckRulesView(type: checkRules(check.checkNumber(newPassword)),
                                   requirement: .containsNumber)
                    Spacer()
                }
                .padding(.leading)
                HStack {
                    CheckRulesView(type: checkRules(check.checkSpecial(newPassword)),
                                   requirement: .containsSpecial)
                    Spacer()
                }
                .padding(.leading)
            }
            .padding(.horizontal)

            CustomTextField(style: .password,
                            icon: Icon.lock,
                            title: "Repetir senha",
                            text: $repeatNewPassword,
                            textFiledState: .active)

            Text("Voce será deslogado de todos os dispositivos e precisará logar com a nova senha")
                .font(Style.Typography.bodyLittleSmall)
                .foregroundColor(Style.ColorPalette.text)
                .padding(.horizontal)
            Buttons(title: "REDEFINIR SENHA") {
                // receber função dp backend
            }
            .padding()
        }
    }

    private func checkRules(_ rule: Bool) -> CheckRulesView.TypeCheck {
        if rule {
            return .check
        } else {
            return .close
        }
    }
}

struct NewPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordScreen()
    }
}
