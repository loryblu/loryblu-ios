import SwiftUI

struct MenuResponsibleEditView: View {
    @State var formConfig: FormConfig

    struct Props {
        var user: User
        var image: Image
        var isAvaliable: Bool
        var onClose: ClosureType.VoidVoid?
    }

    let props: Props

    init(props: Props) {
        self.props = props
        let config = FormConfig(user: props.user, image: props.image)
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
                    text: $formConfig.user.parentName,
                    textFiledState: props.isAvaliable ? .active : .disable
                )
                .padding(.bottom, 30)

                Text(LBStrings.General.email)
                    .font(LBFont.buttonSmall)

                LBTextField(
                    style: .common,
                    icon: LBIcon.mail,
                    title: String(),
                    text: $formConfig.user.parentName,
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
                    text: $formConfig.user.parentName,
                    textFiledState: props.isAvaliable ? .active : .disable
                )

                if props.isAvaliable {
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
        var user: User
        var image: Image
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
    let user = User(parentName: "", childrens: [])
    MenuResponsibleEditView(
        props: .init(
            user: user,
            image: LBIcon.childTree.image,
            isAvaliable: false
        )
    )
}
