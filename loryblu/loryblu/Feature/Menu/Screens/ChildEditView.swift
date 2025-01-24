import SwiftUI

struct ChildEditView: View {
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
            children: String(),
            birthday: Date(),
            gender: String()
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

            VStack(spacing: 32) {
                VStack(alignment: .leading) {
                    Text(LBStrings.Menu.childName)
                        .font(LBFont.buttonSmall)

                    LBTextField(
                        style: .common,
                        icon: LBIcon.user,
                        title: String(),
                        text: $formConfig.children,
                        textFiledState: props.isAvaliable ? .active : .disable,
                        action: nil
                    )
                }

                VStack(alignment: .leading) {
                    Text(LBStrings.Register.birthDay)
                        .font(LBFont.buttonSmall)

                    LBTextField(
                        style: .common,
                        icon: LBIcon.cake,
                        title: String(),
                        text: $formConfig.children,
                        textFiledState: props.isAvaliable ? .active : .disable,
                        action: nil
                    )
                }

                VStack(alignment: .leading) {
                    Text(LBStrings.General.gender)
                        .font(LBFont.buttonSmall)

                    bottonsGender
                }

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
                formConfig.children = appData.userData?.data.user.childrens.first?.fullname ?? String()
            }
        }
        .locbookToolbar(title: LBStrings.Menu.profileUser, showCloseButton: false) {
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

    var bottonsGender: some View {
        HStack(spacing: 16) {
            LBGenderButton(gender: .male, isActive: formConfig.gender == "male", isAvailable: props.isAvaliable) {
                formConfig.gender = appData.userData?.data.user.childrens.first?.gender ?? ""
            }

            LBGenderButton(gender: .female, isActive: formConfig.gender == "female", isAvailable: props.isAvaliable) {
                formConfig.gender = appData.userData?.data.user.childrens.first?.gender ?? ""
            }
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

extension ChildEditView {
    struct FormConfig {
        var image: Image
        var children: String
        var birthday: Date
        var gender: String
    }
}

extension ChildEditView.Props: Hashable {
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
    let user = User(parentName: "", childrens: [])
    ChildEditView(
        props: .init(
            image: LBIcon.parentsTree.image,
            isAvaliable: true,
            onClose: {},
            onNextView: {}
        )
    )
    .environmentObject(appData)
}
