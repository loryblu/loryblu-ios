import SwiftUI

struct LBTextField: View {
    enum TexfieldType {
        case common
        case password
        case date
    }

    enum TextFieldState: CGFloat, Equatable {
        case active = 0
        case alert = 2
    }

    let style: TexfieldType
    let icon: LBIcon?
    let title: String

    @Binding var text: String
    @State var isHidden: Bool = true
    @State var presented: Bool = false
    @State var date: Date?
    let textFiledState: TextFieldState

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
                case .date:
                    TextField(title, text: $text, onEditingChanged: { value in
                        presented = value
                    })
                        .onChange(of: text, perform: { _ in
                            date = CalendarSheet.dateFormatter.date(from: text)
                        })
                }
            }
            .padding()
            .foregroundColor(LBColor.placeholder)
            .font(LBFont.bodySmall)
        }
        .background(LBColor.textfield)
        .frame(height: 48)
        .cornerRadius(8)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
            .stroke(LBColor.error, lineWidth: textFiledState.rawValue)
        })
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
            return LBIcon.eyeClose.image
        }
        return LBIcon.eyeOpen.image
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var presented = true
        @State var value = ""

        VStack {
            LBTextField(
                style: .common,
                icon: LBIcon.lock,
                title: "User",
                text: .constant("Email"),
                textFiledState: .alert
            )

            LBTextField(
                style: .password,
                icon: LBIcon.lock,
                title: "User",
                text: .constant("12345"),
                textFiledState: .active
            )

            LBTextField(style: .date,
                        icon: LBIcon.cake,
                        title: "Data de Aniversário",
                        text: .constant(""),
                        textFiledState: .active)
        }
        .calendarSheet(presented: $presented, value: $value)
    }
}
