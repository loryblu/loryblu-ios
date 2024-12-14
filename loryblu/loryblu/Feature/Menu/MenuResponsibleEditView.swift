import SwiftUI

struct MenuResponsibleEditView: View {
    let image: Image
    @Binding var user: User
    @State var isAvaliable: Bool

    var body: some View {
        VStack {
            Spacer()
            HStack {
                imageDefault
            }
            .frame(maxWidth: .infinity)
            .frame(height: 148)
            .background(LBColor.textfield)
            .padding(.bottom, 60)

            VStack(alignment: .leading) {
                Text(LBStrings.Menu.parentsName)
                    .font(LBFont.buttonSmall)

                LBTextField(style: .common,
                            icon: LBIcon.user,
                            title: "" ,
                            text: $user.parentName,
                            textFiledState: isAvaliable ? .active : .disable 
                )
                .padding(.bottom, 30)

                Text(LBStrings.General.email)
                    .font(LBFont.buttonSmall)

                LBTextField(style: .common,
                            icon: LBIcon.mail,
                            title: "",
                            text: $user.parentName,
                            textFiledState: .disable
                )

                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                        .frame(width: 15, height: 15)
                    Text(LBStrings.Menu.suportInfPart1)
                        .font(.caption2) +
                    Text(LBStrings.Menu.suportInfPart2)
                        .bold()
                        .font(.caption2)
                        .underline() +
                    Text(LBStrings.Menu.suportInfPart3)
                        .font(.caption2)
                }
                .padding(.init(top: 10, leading: 0, bottom: 30, trailing: 0))

                Text(LBStrings.General.password)
                    .font(LBFont.buttonSmall)

                LBTextField(style: .changePassword,
                            icon: LBIcon.lock,
                            title: "",
                            text: $user.parentName,
                            textFiledState: isAvaliable ? .active : .disable
                )

                if isAvaliable {
                    bottomBody
                        .padding(.top, 68)
                }
                Spacer()
            }
            .padding()
        }
    }

    var imageDefault: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 96, height: 96)
                .padding()
            image
                .frame(width: 79, height: 79)
        }
    }

    var bottomBody: some View {
        HStack(spacing: 16) {
            LBButton(title: LBStrings.General.cancel, style: .primaryOff) {
                // MARK: - TODO fazer fluxo de tela
            }

            LBButton(title: LBStrings.General.save) {
                // MARK: - TODO fazer uddate na API
            }
        }
    }
}

#Preview {
    MenuResponsibleEditView(image: LBIcon.parentsTree2.image,
                            user: .constant(User(
                                                parentName: "Rodrigo Silva",
                                                childrens: [Child(
                                                    id: 01,
                                                    fullname: "Zeider Silva",
                                                    gender: "male",
                                                    birthdate: "27/01/2020"
                                                )]
                                            )),
                            isAvaliable: false
                            )
}
