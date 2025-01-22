import SwiftUI

struct MenuResponsibleEditView: View {
    @EnvironmentObject var appData: AppData
    @State var formConfig: FormConfig

    struct Props {
        var image: Image
        var isAvaliable: Bool
        var onClose: ClosureType.VoidVoid?
    }

    let props: Props

    init(props: Props) {
        self.props = props
        let config = FormConfig(
            image: props.image,
            user: String(),
            email: String(),
            password: String()
        )
        self._formConfig = State(initialValue: config)
    }

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

                LBTextField(
                    style: .common,
                    icon: LBIcon.user,
                    title: String(),
                    text: $formConfig.user,
                    textFiledState: props.isAvaliable ? .active : .disable
                )
                .padding(.bottom, 30)

                Text(LBStrings.General.email)
                    .font(LBFont.buttonSmall)

                LBTextField(
                    style: .common,
                    icon: LBIcon.mail,
                    title: String(),
                    text: $formConfig.email,
                    textFiledState: .disable
                )

                HStack {
                    Image(LBIcon.infoGray.rawValue)
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

                LBTextField(
                    style: .changePassword,
                    icon: LBIcon.lock,
                    title: String(),
                    text: $formConfig.password,
                    textFiledState: props.isAvaliable ? .active : .disable
                )

                if props.isAvaliable {
                    bottomBody
                        .padding(.top, 68)
                }
                Spacer()
            }
            .padding()
            .onAppear {
                formConfig.user = appData.userData?.data.user.parentName ?? String()
            }
        }
        .locbookToolbar(title: LBStrings.Menu.profileUser, showCloseButton: true)
        .backgroundStyle(LBColor.background)
    }

    var imageDefault: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 96, height: 96)
                .padding()
            formConfig.image
                .resizable()
                .frame(width: 79, height: 79)
        }
    }

    var bottomBody: some View {
        HStack(spacing: 16) {
            LBButton(title: LBStrings.General.cancel, style: .primaryOff) {
                props.onClose?()
            }

            LBButton(title: LBStrings.General.save) {
                // MARK: - TODO fazer update na API
            }
        }
    }
}

extension MenuResponsibleEditView {
    struct FormConfig {
        var image: Image
        var user: String
        var email: String
        var password: String
    }
}

extension MenuResponsibleEditView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    let user = User(parentName: "Maria de Jesus Santos", childrens: [])
    MenuResponsibleEditView(
        props: .init(
            image: LBIcon.childTree.image,
            isAvaliable: false
        )
    )
}
