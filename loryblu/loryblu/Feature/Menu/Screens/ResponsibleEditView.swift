import SwiftUI

struct ResponsibleEditView: View {
    @EnvironmentObject var appData: AppData
    @State var formConfig: FormConfig

    struct Props {
        var image: Image
        var isAvaliable: Bool
        var onClose: ClosureType.VoidVoid?
        var onNextView: ClosureType.VoidVoid?
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
                    textFiledState: props.isAvaliable ? .active : .disable,
                    action: nil
                )
                .padding(.bottom, 30)

                Text(LBStrings.General.email)
                    .font(LBFont.buttonSmall)

                LBTextField(
                    style: .common,
                    icon: LBIcon.mail,
                    title: String(),
                    text: $formConfig.email,
                    textFiledState: .disable,
                    action: nil
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
                    textFiledState: props.isAvaliable ? .active : .disable,
                    action: {
                        props.onNextView?()
                    }
                )

                if props.isAvaliable {
                    Spacer()
                    bottomBody
                        .padding(.bottom, 24)
                } else {
                    Spacer()
                }
            }
            .padding()
            .onAppear {
                formConfig.user = appData.userData?.data.user.parentName ?? String()
            }
        }
        .locbookToolbar(title: LBStrings.Menu.profileChild, showCloseButton: true) {
            props.onClose?()
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

extension ResponsibleEditView {
    struct FormConfig {
        var image: Image
        var user: String
        var email: String
        var password: String
    }
}

extension ResponsibleEditView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @StateObject var appData: AppData = .init()
    let user = User(parentName: "Maria de Jesus Santos", childrens: [])
    ResponsibleEditView(
        props: .init(
            image: LBIcon.parentsTree.image,
            isAvaliable: true,
            onClose: {},
            onNextView: {}
        )
    )
    .environmentObject(appData)
}
