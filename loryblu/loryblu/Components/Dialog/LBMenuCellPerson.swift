import SwiftUI

struct LBMenuCellPerson: View {
    let onClick: () -> Void
    let functionPerson: String
    let namePerson: String
    let image: Image

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
                Text(functionPerson)
                    .font(LBFont.caption1)
                Text(namePerson)
                    .font(LBFont.bodyLarge)
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
    LBMenuCellPerson(onClick: {

    }, functionPerson: LBStrings.Menu.childName, namePerson: "Roberta Dias", image: LBIcon.childTree.image)
}
