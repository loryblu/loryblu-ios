import SwiftUI

struct LBLabel: View {
    var title: String
    var type: TypeIcon

    enum TypeIcon {
        case check
        case wrong
    }

    var body: some View {
            HStack {
                Label {
                    Text(title)
                        .foregroundColor(textColor)
                        .font(LBFont.bodyLittleSmall)
                } icon: {
                    icon
                        .resizable().frame(width: 12, height: 12)
                }
            }
    }

    private var icon: Image {
        switch type {
        case .check:
            return LBIcon.check.image
        case .wrong:
            return LBIcon.close.image
        }
    }

    private var textColor: Color {
        switch type {
        case .check:
            return LBColor.text
        case .wrong:
            return LBColor.error
        }
    }
}

struct IconLabel_Previews: PreviewProvider {
    static var previews: some View {
        LBLabel(
            title: "Pelo menos uma letra maiúscula",
            type: .check
        )
    }
}
