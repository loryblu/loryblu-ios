import SwiftUI

struct LBfloatingButton: View {
    var text: String
    var icon: LBIcon?
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                if let icon = icon {
                    icon.image
                        .frame(width: 24)
                }
                Text(text)
                    .font(LBFont.button)
                    .frame(height: 48)
                    .frame(minWidth: 155,alignment: .center)
            }
            .padding(.horizontal,12)
            .background(LBColor.backgroundImagetrails)
            .foregroundColor(LBColor.background)
            .cornerRadius(48)
            .shadow(color: .black.opacity(0.3) ,radius: 7 ,x: 3, y: 10)
        }
        .frame(height: 48)
    }
}

#Preview {
    VStack {
        LBfloatingButton(text:"NOVA TAREFA", icon: LBIcon.plus) {
            print("Ok")
        }
    }
}
