import SwiftUI

struct MenuView: View {
    @State var user: User

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(LBStrings.Menu.menu)
                    .font(LBFont.head5)
                Spacer()
                Button {

                } label: {
                    LBIcon.close3.image
                }
            }
            .padding()

            VStack(spacing: 15) {
                HStack {
                    Text(LBStrings.Menu.profile)
                        .font(LBFont.head5)
                        .foregroundStyle(LBColor.loryGray)
                    Spacer()
                }
                LBMenuCellPerson(onClick: {   },
                                 description: LBStrings.Menu.childName,
                                 name: user.childrens.first?.fullname ?? "",
                                 image: LBIcon.childTree.image, style: .person)
                LBMenuCellPerson(onClick: {   },
                                 description: LBStrings.Menu.parentsName,
                                 name: user.parentName ,
                                 image: LBIcon.childTree.image, style: .person)
                HStack {
                    Text(LBStrings.Menu.configuration)
                        .font(LBFont.head5)
                        .foregroundStyle(LBColor.loryGray)
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
    MenuView(user: User(parentName: "Rodrigo", childrens: [Child(id: 01, fullname: "Zeider Silva", gender: "male", birthdate: "27/01/2020")]))
}
