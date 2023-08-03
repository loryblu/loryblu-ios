import SwiftUI

struct ForgotPasswordScreen: View {
    enum FechtEmail {
        case success
        case error
    }
    @EnvironmentObject var model: ForgotPasswordModel
    @State var userEmail: String = "Abc"
    @State var fecthEmail: FechtEmail

    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .frame(width: 187, height: 47)
                    .padding(.bottom, 40)

                Text("Esqueceu a senha?")
                    .font(LBFont.head6)
                    .padding(.bottom, 24)

                Text("Redefina sua senha aqui")
                    .font(LBFont.subtitle)
                    .padding(.bottom, 56)

                LBTextField(style: .common,
                            icon: LBIcon.mail,
                                title: "Email",
                                text: $userEmail,
                                textFiledState: .active)
                .padding(.bottom, 39)

                LBButton(title: "Enviar") {
                    model.login(user: userEmail)
                    if model.isValid {
                        fecthEmail = .success
                    } else {
                        fecthEmail = .error
                    }
                }
                .padding(.bottom, 10)
                .navigationDestination(isPresented: $model.isValid) {
                    NewPasswordScreen()
                }

                HStack {
                    Spacer()
                    switch fecthEmail {
                    case .success:
                        Text("E-mail enviado com sucesso")
                            .font(LBFont.caption)
                            .padding()
                    case .error:
                    Text("Não foi possível encontrar seu email")
                        .font(LBFont.caption)
                        .foregroundColor(LBColor.error)
                        .padding()
                    }
                }
            }
            .padding(.horizontal, 24)
        }

    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen(fecthEmail: ForgotPasswordScreen.FechtEmail.error).environmentObject(ForgotPasswordModel())
    }
}
