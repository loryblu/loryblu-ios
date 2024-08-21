import SwiftUI

struct LBMenuCellPerson: View {
    let onClick: () -> Void
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
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("Nome da criança")
                    .font(LBFont.caption1)
                Text(namePerson)
                    .font(LBFont.bodyLarge)
            }
            Spacer()
            Button {
                onClick()
            } label: {
                
            }


        }
        .frame(width: 327,height: 80)
        .background(LBColor.textfield)
        .clipShape(RoundedRectangle(cornerRadius: 12))

    }
}

#Preview {
    LBMenuCellPerson(onClick: {

    }, namePerson: "Zeider", image: LBIcon.cake.image)
}
