import SwiftUI

struct LBMenuCellPerson: View {
    enum StyleCell {
        case person
        case confuguration
    }

    let onClick: () -> Void
    let description: String
    let name: String
    let image: Image
    let style: StyleCell

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 40, height: 40)
                    .padding(6)
                image
                    .frame(width: 20, height: 20)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(style == .person ? description : name)
                    .font(style == .person ? LBFont.caption1 : LBFont.bodyLarge)
                Text(style == .person ? name : description)
                    .font(style == .person ? LBFont.bodyLarge : LBFont.caption1)
            }
            Spacer()
            Button {
                onClick()
            } label: {
                LBIcon.arrowRight.image
                    .frame(width: 6, height: 12)
                    .padding()
            }

        }
        .frame(width: 327, height: 80)
        .background(LBColor.textfield)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(LBColor.placeholder)
        }
    }
}

#Preview {
    VStack {
        LBMenuCellPerson(onClick: { },
                         description: LBStrings.Menu.childName,
                         name: "Roberta Dias",
                         image: LBIcon.childTree.image,
                         style: .person)

        LBMenuCellPerson(onClick: { },
                         description: "Controle de acessos e gerencie as funcionalidade do app",
                         name: "Segurança",
                         image: LBIcon.shield.image,
                         style: .confuguration)
    }

}
