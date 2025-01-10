import SwiftUI

struct LBAccessControlCell: View {
    @State var isLoccked: Bool
    var title: String
    var description: String
    var image: Image

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 40, height: 40)
                            image
                                .frame(width: 20, height: 20)
                        }
                         Toggle(isOn: $isLoccked) {}
                        .toggleStyle(SymbolToggleStyle())
                    }
                    Text(title)
                        .font(LBFont.button)
                    Text(description)
                        .font(LBFont.bodySmall)
                        .foregroundStyle(LBColor.loryGray)
                }
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))

                Spacer()
            }

        }
        .frame(height: 114)
        .frame(maxWidth: .infinity)
        .background(LBColor.textfield)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(LBColor.placeholder)
        }
    }
}

#Preview {
    VStack {
        LBAccessControlCell(isLoccked: false ,
                            title: "Perfil da Criança",
                            description: "Bloqueia a edição do perfil da criança",
                            image: LBIcon.childTree.image)
        LBAccessControlCell(isLoccked: true ,
                            title: "Perfil da Criança",
                            description: "Bloqueia ações: criar , editar e excluir tarefas.",
                            image: LBIcon.childTree.image)
    }
    .padding(20)
}
