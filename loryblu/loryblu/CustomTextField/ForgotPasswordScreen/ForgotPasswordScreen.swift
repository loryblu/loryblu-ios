import SwiftUI

struct ForgotPasswordScreen: View {
    enum FechtEmail {
        case success
        case error
    }

    @Binding var userEmail: String
    @Binding var isHidden: Bool
    @State var fecthEmail: FechtEmail
    var body: some View {
        VStack {
            Image("logo")
                .frame(width: 187, height: 47)
                .padding(40)
            Text("Esqueceu a senha?")
                .font(Style.Typography.head6)
                .padding(24)
            Text("Redefina sua senha aqui")
                .font(Style.Typography.subtitle)

            CustomTextField(style: .common,
                            icon: Icon.mail,
                            title: "Email",
                            text: $userEmail,
                            isHidden: $isHidden,
                            textFiledState: .active)
            VStack {
                Buttons(title: "Enviar") {

                }
                .padding()

                HStack {
                    Spacer()

                    switch fecthEmail {
                    case .success:
                        Text("E-mail enviado com sucesso")
                            .font(Style.Typography.caption)
                            .padding()
                    case .error:
                    Text("Não foi possível encontrar seu email")
                        .font(Style.Typography.caption)
                        .foregroundColor(Style.ColorPalette.error)
                        .padding()
                    }
                }
            }
        }
    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen(
            userEmail: .constant(""),
            isHidden: .constant(false),
            fecthEmail: .success )
    }
}
