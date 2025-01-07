import SwiftUI

struct LBAccessControlCell: View {
    let isLoccked: Bool = false
    let title: String
    let description: String
    let image: Image

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 40, height: 40)
                        .padding(6)
                    image
                        .frame(width: 20, height: 20)
                }
            }
            Text(title)
                .font(LBFont.titleLarge)
            Text(description)
                .font(LBFont.caption1)
                .foregroundStyle(LBColor.loryGray)
            
        }
        .frame(height: 114)
        .frame(maxWidth: .infinity)
        .background(LBColor.textfield)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(LBColor.placeholder)
        }
    }
}

#Preview {
    LBAccessControlCell(title: "Perfil da Criança",
                        description: "Bloqueia a edição do perfil da criança",
                        image: LBIcon.childTree.image)
}
