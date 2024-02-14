import Factory
import SwiftUI

struct ResetPasswordScreen: View {
    
    @ObservedObject var model: ResetPasswordModel
    @State private var userEmail: String = ""
    
    var body: some View {
        VStack {
            LBIcon.logoName.image
                .frame(width: 187, height: 47)
                .padding(.bottom, 40)
            
            Text(LBStrings.SetPassword.forget)
                .font(LBFont.titleTask)
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
            .textInputAutocapitalization(.never)
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

extension ResetPasswordScreen {
    static func build() -> ResetPasswordScreen {
        ResetPasswordScreen(model: .init(fecht: .idle, container: Container.shared))
    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordScreen(model: .init(container: Container()))
    }
}
