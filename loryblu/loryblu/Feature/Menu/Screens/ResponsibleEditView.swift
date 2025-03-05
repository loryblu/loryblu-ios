import SwiftUI
import PhotosUI

struct ResponsibleEditView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss
    @State var formConfig: FormConfig
    @State private var showCustomActionSheet = false
    @State private var showAlertDeletePhoto = false

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
            ZStack(alignment: .bottomTrailing) {
                imageDefault

                if props.isAvaliable {
                    Button {
                        showCustomActionSheet.toggle()
                    } label: {
                        Image(LBIcon.editWhite.rawValue)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.white)

                    }
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(LBColor.buttonPrimary))
                    .contentShape(Circle())
                    .padding(.init(top: 0, leading: 0, bottom: 16, trailing: 16))
                }

            }
            .frame(maxWidth: .infinity)
            .frame(height: 148)
            .background(LBColor.textfield)
            .padding(.bottom, 60)

            VStack(alignment: .leading) {
                if !props.isAvaliable {
                    AlertSimpleView(
                        text: "Ações bloqueadas! Você pode alterar as permissões em ",
                        subText: "Controle de Acesso.",
                        icon: .infoBold,
                        textColor: LBColor.loryGray,
                        borderColor: .black
                    )
                    .padding(.bottom, 24)
                }

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
        .locbookToolbar(title: LBStrings.Menu.profileUser, showCloseButton: true) {
            props.onClose?()
        }
        .overlay {
            if showCustomActionSheet {
                GeometryReader { geometry in
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .animation(.easeInOut, value: showCustomActionSheet)

                        VStack {
                            Spacer()
                            LBActionSheet(
                                isPresented: $showCustomActionSheet,
                                deletePhoto: $showAlertDeletePhoto,
                                image: LBIcon.parentsTree.rawValue
                            )
                            .frame(width: geometry.size.width)
                            .frame(height: 280)
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut, value: showCustomActionSheet)
                        }
                        .zIndex(1)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showAlertDeletePhoto) {
            LBAlertConfirmation(
                textInfo: "Você quer excluir a",
                highlightText: "Foto de Perfil",
                textButtonOne: "Cancelar",
                textButtonTwo: "Excluir",
                onClosed: { showAlertDeletePhoto = false },
                onCancel: { showAlertDeletePhoto = false }
            )
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
                // fazer update na API
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
