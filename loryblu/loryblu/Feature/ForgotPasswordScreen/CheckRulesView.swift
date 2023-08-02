import SwiftUI

struct CheckRulesView: View {
    var type: TypeCheck
    var requirement: PasswordRequirements

    enum PasswordRequirements: String {
        case containsSize = "Pelo menos 8 caracteres"
        case containsUppercase = "Pelo menos uma letra maiúscula"
        case containsLowercase = "Letras minúsculas"
        case containsNumber = "Números"
        case containsSpecial = "Pelo menos um caractere especial: ! @ # $ % *"

        var requirements: String {
            String(self.rawValue)
        }
    }

    enum TypeCheck: String {
        case check
        case close

        var image: Image {
            Image(self.rawValue)
        }
    }

    private var textColor: Color {
        switch type {
        case .check:
            return Style.ColorPalette.text
        case .close:
            return Style.ColorPalette.error
        }
    }

    var body: some View {
        HStack {
            Label {
                Text(requirement.rawValue)
                    .foregroundColor(textColor)
                    .font(Style.Typography.caption)
            } icon: {
                type.image
                    .resizable().frame(width: 12, height: 12)
            }

        }
    }
}

struct CheckRulesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            CheckRulesView(type: .check, requirement: .containsLowercase)
            CheckRulesView(type: .close, requirement: .containsNumber)
        }
   }
}
