import SwiftUI

struct MenuView: View {
    var user: User?

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Menu")
                Spacer()
                Button {

                } label: {
                    Text("X")
                }
            }
            .padding(.trailing, 20)
            VStack(spacing: 10) {
                HStack {
                    Text("Perfil")
                    Spacer()
                }
                LBMenuCellPerson(onClick: {   },
                                 description: LBStrings.Menu.childName,
                                 name: user?.childrens.first?.fullname ?? "",
                                 image: LBIcon.childTree.image, style: .person)
                LBMenuCellPerson(onClick: {   },
                                 description: LBStrings.Menu.parentsName,
                                 name: user?.parentName ?? "",
                                 image: LBIcon.childTree.image, style: .person)
                HStack {
                    Text(LBStrings.Menu.configuration)
                    Spacer()
                }

                LBMenuCellPerson(onClick: {   },
                                 description: LBStrings.Menu.accessControl,
                                 name: LBStrings.Menu.security,
                                 image: LBIcon.shield.image, style: .configuration)
                LBMenuCellPerson(onClick: {   },
                                 description: "",
                                 name: LBStrings.Menu.faq,
                                 image: LBIcon.questionMark.image, style: .configuration)
                LBMenuCellPerson(onClick: {   },
                                 description: "",
                                 name: LBStrings.Menu.privacyTerms,
                                 image: LBIcon.privacyTerms.image, style: .configuration)
                LBMenuCellPerson(onClick: {   },
                                 description: "",
                                 name: LBStrings.Menu.exit,
                                 image: LBIcon.exit.image, style: .exit)
                .padding(.top, 20)

            }
            .padding(20)

        }
        .frame(maxWidth: .infinity)
        Spacer()
    }
}

#Preview {
    MenuView()
}
