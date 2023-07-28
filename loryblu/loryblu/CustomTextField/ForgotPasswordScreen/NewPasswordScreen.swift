import SwiftUI

struct NewPasswordScreen: View {
    @State var check: CheckdeRules = CheckdeRules()
    @State var newPassword: String = ""
    @State var repeatNewPassword: String = ""
    @State var isHidden: Bool = false
     var body: some View {
        VStack {
            Image("logo")
                .frame(width: 187, height: 47)
                .padding(40)
            Text("Criar nova senha")
                .font(Style.Typography.head6)
                .padding(24)
            Text("Redefina sua senha aqui")
                .font(Style.Typography.subtitle)

            CustomTextField(style: .password,
                            icon: Icon.lock,
                            title: "Nova senha",
                            text: $newPassword,
                            isHidden: $isHidden,
                            textFiledState: .active)

            VStack(alignment: .leading) {
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

            CustomTextField(style: .password,
                            icon: Icon.lock,
                            title: "Repetir senha",
                            text: $repeatNewPassword,
                            isHidden: $isHidden,
                            textFiledState: .active)
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
