import SwiftUI

struct IconLabel: View {
    var title: String
    var type: TypeIcon

    enum TypeIcon {
        case check
        case wrong
    }

    @Binding var text: String
    @Binding var checking: Bool

    var body: some View {
            HStack {
                Label {
                    Text(text)
                        .foregroundColor(textColor)
                } icon: {
                    icon
                        .resizable().frame(width: 12, height: 12)
                }
            }
    }

    private var icon: Image {
        switch type {
        case .check:
            return Icon.check.image
        case .wrong:
            return Icon.close.image
        }
    }

    private var textColor: Color {
        switch type {
        case .check:
            return Style.ColorPalette.text
        case .wrong:
            return Style.ColorPalette.error
        }
    }
}

struct IconLabel_Previews: PreviewProvider {
    static var previews: some View {
        IconLabel(
            title: "Pelo menos uma letra maiúscula",
            type: .check,
            text: .constant("Pelo menos uma letra maiúscula"),
            checking: .constant(false)
        )
    }
}
