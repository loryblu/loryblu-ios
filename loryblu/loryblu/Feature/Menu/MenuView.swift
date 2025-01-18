import SwiftUI

struct MenuView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appData: AppData
    @StateObject var menuViewModel: MenuViewModel = MenuViewModel()
    @State private var showWebView = false
    @State var urlString = String()
    @State var urlFaq = Server.faq
    @State var urlTerms = Server.termsOfUse
    @State private var navigationTitle = String()
    @State var props: Props

    var userName: String {
        appData.userData?.data.user.parentName ?? String()
    }

    var childName: String {
        appData.userData?.data.user.childrens.first?.fullname ?? String()
    }

    var userImage: Image {
        LBIcon.parentsTree.image
    }

    var childImage: Image {
        LBIcon.childTree.image
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
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
                                .font(LBFont.titleTask)
                                .foregroundStyle(LBColor.loryGray)
                            Spacer()
                        }

                        LBMenuCellPerson(
                            onClick: {  },
                            description: LBStrings.Menu.childName,
                            name: childName,
                            image: childImage,
                            style: .person
                        )
                        LBMenuCellPerson(
                            onClick: {
                                props.showNextPage?()
                            },
                            description: LBStrings.Menu.parentsName,
                            name: userName,
                            image: userImage,
                            style: .person
                        )

                        HStack {
                            Text(LBStrings.Menu.configuration)
                                .font(LBFont.titleTask)
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
                .padding(
                    .init(top: 50, leading: 0, bottom: 0, trailing: 0)
                )

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
}

extension MenuView {
    struct Props {
        let showNextPage: ClosureType.VoidVoid?
    }
}

extension MenuView.Props: Hashable {
    static func == (lhs: MenuView.Props, rhs: MenuView.Props) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

extension MenuView {
    static func build(nextPage: ClosureType.VoidVoid?) -> Self {
        MenuView(
            urlString: String(),
            props: .init(showNextPage: nextPage)
        )
    }
}

#Preview {
    MenuView(urlString: String(), props: .init(showNextPage: nil))
}
