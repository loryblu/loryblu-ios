import SwiftUI

struct LBTextField: View {
    enum TexfieldType {
        case common
        case password
    }

    enum TextFieldState: CGFloat, Equatable {
        case active = 0
        case alert = 2
    }

    let style: TexfieldType
    let icon: LBIcon?
    let title: String

    @Binding var text: String
    @Binding var isHidden: Bool
<<<<<<<< HEAD:loryblu/loryblu/Components/Base/LBTextField.swift
    let textFiledState: TextFieldState
========
    @State var textFiledState: TextFieldState
>>>>>>>> develop:loryblu/loryblu/Components/CustomTextField.swift

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
                    if isHidden {
                        SecureField(title, text: $text)
                        passwordButton
                            .accentColor(LBColor.text)
                    } else {
                        TextField(title, text: $text)
                        passwordButton
                            .accentColor(LBColor.text)
                    }
                }
            }
            .padding()
            .foregroundColor(LBColor.placeholder)
            .font(LBFont.bodySmall)
        }
        .background(LBColor.textfield)
        .frame(height: 48)
        .cornerRadius(8)
        .border(LBColor.error,
                width: textFiledState.rawValue)
    }

    var passwordButton: some View {
        Button {
            isHidden.toggle()
        } label: {
            secretIcon
        }
    }

    var secretIcon: some View {
        if isHidden {
<<<<<<<< HEAD:loryblu/loryblu/Components/Base/LBTextField.swift
            return LBIcon.eyeClose.image
========
            return Icon.eyeClose.image
>>>>>>>> develop:loryblu/loryblu/Components/CustomTextField.swift
        }
        return LBIcon.eyeOpen.image
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LBTextField(
                style: .common,
                icon: LBIcon.lock,
                title: "User",
                text: .constant("Email"),
                isHidden: .constant(true),
<<<<<<<< HEAD:loryblu/loryblu/Components/Base/LBTextField.swift
                textFiledState: .alert
            )
========
                textFiledState: .alert)
>>>>>>>> develop:loryblu/loryblu/Components/CustomTextField.swift

            LBTextField(
                style: .password,
                icon: LBIcon.lock,
                title: "User",
                text: .constant("12345"),
                isHidden: .constant(false),
<<<<<<<< HEAD:loryblu/loryblu/Components/Base/LBTextField.swift
                textFiledState: .active
            )
========
                textFiledState: .active)
>>>>>>>> develop:loryblu/loryblu/Components/CustomTextField.swift
        }
    }
}
