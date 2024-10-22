import SwiftUI

struct MenuView: View {
    @Environment(\.dismiss) var dismiss
    @State var user: User?
    @StateObject var menuViewModel: MenuViewModel = MenuViewModel()
    @State private var showWebView = false
    @State var urlString = String()
    @State var urlFaq = Server.faq
    @State var urlTerms = Server.termsOfUse
    @State private var navigationTitle = String()

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text(LBStrings.Menu.menu)
                        .font(LBFont.head5)
                    Spacer()
                    Button {
                        dismiss()
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

                    LBMenuCellPerson(
                        onClick: { },
                        description: LBStrings.Menu.childName,
                        name: user?.childrens.first?.fullname ?? String(),
                        image: LBIcon.childTree.image,
                        style: .person
                    )
                    LBMenuCellPerson(
                        onClick: { },
                        description: LBStrings.Menu.parentsName,
                        name: user?.parentName ?? String(),
                        image: LBIcon.parentsTree.image,
                        style: .person
                    )

                    HStack {
                        Text(LBStrings.Menu.configuration)
                            .font(LBFont.head5)
                            .foregroundStyle(LBColor.loryGray)
                        Spacer()
                    }
                    LBMenuCellPerson(
                        onClick: {},
                        description: LBStrings.Menu.accessControl,
                        name: LBStrings.Menu.security,
                        image: LBIcon.shield.image,
                        style: .configuration
                    )

                    Group {
                        LBMenuCellPerson(
                            onClick: {
                                urlString = urlFaq
                                navigationTitle = LBStrings.Menu.faq
                                showWebView = true
                            },
                            description: String(),
                            name: LBStrings.Menu.faq,
                            image: LBIcon.questionMark.image,
                            style: .configuration
                        )

                        LBMenuCellPerson(
                            onClick: {
                                urlString = urlTerms
                                navigationTitle = LBStrings.Menu.privacyTerms
                                showWebView = true
                            },
                            description: String(),
                            name: LBStrings.Menu.privacyTerms,
                            image: LBIcon.privacyTerms.image,
                            style: .configuration
                        )
                        .sheet(isPresented: $showWebView) {
                            MenuWebView(title: $navigationTitle, urlString: $urlString)
                        }

                    }

                    LBMenuCellPerson(
                        onClick: {
                            menuViewModel.openExitConfirmation()
                        },
                        description: String(),
                        name: LBStrings.Menu.exit,
                        image: LBIcon.exit.image,
                        style: .exit
                    )
                    .padding(.top, 16)
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity)
            .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))

            if menuViewModel.openExitConfirmationDialog {
                LBExitAppConfirmation {
                    menuViewModel.logout()
                } onCancel: {
                    menuViewModel.giveUpToLogout()
                }
            }

        }
    }
}

#Preview {
    MenuView(
        user: User(
            parentName: "Rodrigo",
            childrens: [Child(
                id: 01,
                fullname: "Zeider Silva",
                gender: "male",
                birthdate: "27/01/2020"
            )]
        ), urlString: ""
    )
}
