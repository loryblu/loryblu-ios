import SwiftUI

struct SymbolToggleStyle: ToggleStyle {
    var image: String = LBIcon.unlock.rawValue
    var activeColor: Color = LBColor.buttonBackgroundDark

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? activeColor : LBColor.placeholder)
                .overlay {
                    Image(configuration.isOn ? image : LBIcon.lockToggle.rawValue)
                        .foregroundColor(configuration.isOn ? activeColor : LBColor.placeholder)
                        .offset(x: configuration.isOn ? -10 : 10)

                    Circle()
                        .fill(LBColor.background)
                        .padding(3)
                        .offset(x: configuration.isOn ? 10 : -10)
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
