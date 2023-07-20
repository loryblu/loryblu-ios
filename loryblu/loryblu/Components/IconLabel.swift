import SwiftUI

struct IconLabel: View {
    var title: String
    var type: TypeIcon
    var icon: Icon?

    enum TypeIcon {
        case check
        case wrong

        var iconImage: String {
            switch self {
            case .check:
                return Icon.check.rawValue
            case .wrong:
                return Icon.close.rawValue
            }
        }
    }

    @Binding var text: String
    @Binding var checking: Bool

    var body: some View {
            HStack {
                if let icon = icon {
                    icon.image
                        .frame(width: 12)
                }

                switch type {
                case .check:
                    Image(Icon.check.rawValue)
                    Text(text)
                        .foregroundColor(Style.ColorPalette.text)
                case .wrong:
                    Image(Icon.close.rawValue)
                    Text(text)
                        .foregroundColor(Style.ColorPalette.error)
                }

//                Image(Icon.check.rawValue)
//                Text(text)
//                    .font(Style.Typography.bodyLittleSmall)
//                    .foregroundColor(Style.ColorPalette.text)
            }
    }
}

struct IconLabel_Previews: PreviewProvider {
    static var previews: some View {
        IconLabel(title: "Pelo menos uma letra maiúscula", type: .check, text: .constant("Pelo menos uma letra maiúscula"), checking: .constant(false))
    }
}
