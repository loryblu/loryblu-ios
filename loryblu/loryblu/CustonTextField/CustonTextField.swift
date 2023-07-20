import SwiftUI

struct CustonTextField: View {
    enum TexfieldType {
        case common
        case password
    }

    enum TextFieldState: CGFloat {
        case active = 0
        case alert = 2
    }

    let style: TexfieldType
    let icon: Icon?
    let title: String

    @Binding var text: String
    @Binding var isHide: Bool
    @State var textFiledState: TextFieldState

    var body: some View {

        HStack {
            HStack {
                if let icon = icon {
                    icon.image
                        .frame(width: 22)
                }

                switch style {
                case .common:
                    TextField(title, text: $text)
                case .password:
                    if isHide {
                        SecureField(title, text: $text)
                        passwordButton
                            .accentColor(.black)
                    } else {
                        TextField(title, text: $text)
                        passwordButton
                            .accentColor(.black)
                    }
                }
            }
            .padding()
            .foregroundColor(Style.ColorPalette.placeholder)
            .font(Style.Typography.bodySmall)
        }
        .background(Style.ColorPalette.textfield)
        .frame(height: 48)
        .cornerRadius(8)
        .border(Style.ColorPalette.error,
                width: textFiledState.rawValue)
        .padding()
    }

    var passwordButton: some View {
        Button {
            isHide.toggle()
        } label: {
            secretIcon
        }
    }

    var secretIcon: some View {
        if isHide {
            return Icon.eyeClose.image
        }
        return Icon.eyeOpen.image
    }
}

struct CustonTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustonTextField(style: .common,
                            icon: Icon.lock,
                            title: "User",
                            text: .constant("Email"),
                            isHide: .constant(true),
                            textFiledState: .alert)

            CustonTextField(style: .password,
                            icon: Icon.lock,
                            title: "User",
                            text: .constant("12345"),
                            isHide: .constant(false),
                            textFiledState: .active)
        }
    }
}
