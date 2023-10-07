import SwiftUI

struct ResetPasswordScreen: View {

    @ObservedObject var model: ResetPasswordModel = ResetPasswordModel()
    @State var userEmail: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                LBIcon.logo.image
                    .frame(width: 187, height: 47)
                    .padding(.bottom, 40)

                Text(LBStrings.SetPassword.forget)
                    .font(LBFont.head6)
                    .padding(.bottom, 24)

                Text(LBStrings.SetPassword.reset)
                    .font(LBFont.subtitle)
                    .padding(.bottom, 56)

                LBTextField(style: .common,
                            icon: LBIcon.mail,
                            title: LBStrings.General.email,
                                text: $userEmail,
                                textFiledState: .active)
                .padding(.bottom, 39)

                LBButton(title: LBStrings.General.send) {
                    Task {
                       await model.recoveryPassowrd(with: userEmail)
                    }

                }
                .padding(.bottom, 10)

                    HStack {
                        Spacer()
                        switch model.fecht {
                        case .success:
                            Text(LBStrings.SetPassword.success)
                                .font(LBFont.caption)
                                .padding()
                        case .error:
                            Text(LBStrings.SetPassword.error)
                            .font(LBFont.caption)
                            .foregroundColor(LBColor.error)
                            .padding()
                        case .idle:
                            Text("")
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
        ResetPasswordScreen(model: ResetPasswordModel())
    }
}
