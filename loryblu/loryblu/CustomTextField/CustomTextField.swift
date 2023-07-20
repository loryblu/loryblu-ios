import SwiftUI

struct CustomTextField: View {
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
    @Binding var IsHidden: Bool
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
                    if IsHidden {
                        SecureField(title, text: $text)
                        passwordButton
                            .accentColor(Style.ColorPalette.text)
                    } else {
                        TextField(title, text: $text)
                        passwordButton
                            .accentColor(Style.ColorPalette.text)
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
            IsHidden.toggle()
        } label: {
            secretIcon
        }
    }

    var secretIcon: some View {
        if IsHidden {
            return Icon.eyeClose.image
        }
        return Icon.eyeOpen.image
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomTextField(
                style: .common,
                icon: Icon.lock,
                title: "User",
                text: .constant("Email"),
                IsHidden: .constant(true),
                textFiledState: .alert)

            CustomTextField(
                style: .password,
                icon: Icon.lock,
                title: "User",
                text: .constant("12345"),
                IsHidden: .constant(false),
                textFiledState: .active)
        }
    }
}
