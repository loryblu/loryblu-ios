import SwiftUI

struct ChildProfileView: View {
    
    struct Props {
        var title: String = ""
        var childName: String = ""
        var childBirth: String = ""
        var childGender: String = ""
        var childUrlImg: String? = nil
        var editionBlocked: Bool = false
        var onClose: ClosureType.VoidVoid?
    }

    // MARK: - Properties
    let props: ChildProfileView.Props
    
    @StateObject var viewModel = ChildProfileViewModel()
    @FocusState private var focusedField: RegisterChildViewModel.FocusedField?
    @State var childName: String
    
    init(props: ChildProfileView.Props, childName: String = "") {
        self.props = props
        self.childName = props.childName
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            ZStack {
                Rectangle()
                    .fill(LBColor.backgroundProfileImage)
                    .frame(width: .infinity, height: 148, alignment: .top)
                ZStack(alignment: .bottomTrailing) {
                    if props.childUrlImg != nil {
                        AsyncImage(url: props.childUrlImg!).aspectRatio(contentMode: .fit)
                    } else {
                        Image("placeholder_childProfile")
                    }
                    if props.editionBlocked != true {
                        Button(action: {
                            
                        }) {
                            Label("Edit_Pencil", systemImage: "pencil")
                                .labelStyle(.iconOnly)
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .background(LBColor.buttonPrimary)
                                .cornerRadius(20)
                        }.padding([.leading], 12)
                    }
                }
            }
            .background(LBColor.textfield)
            VStack(spacing: 8) {
                Text(LBStrings.Profile.childName)
                    .font(LBFont.bodyMedium)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                LBTextField(
                    style: .common,
                    icon: LBIcon.lock,
                    title: "Nome da criança",
                    text: $childName,
                    textFiledState: props.editionBlocked ? .disable : .active
                )
            }
            .padding([.trailing,.leading], 24)
            VStack(spacing: 8) {
                Text(LBStrings.Profile.birthDay)
                    .font(LBFont.bodyMedium)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                LBDatePickerTextField(
                    icon: .cake,
                    title: LBStrings.Register.birthDay,
                    date: $viewModel.childBirth,
                    state: .active
                )
                .textInputAutocapitalization(.never)
            }.padding([.trailing,.leading], 24)
            VStack(spacing: 8) {
                Text(LBStrings.Profile.gender)
                    .font(LBFont.bodyMedium)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 15) {
                    LBGenderButton(gender: .male, isActive: viewModel.childGender == .male) {
                        viewModel.childGender = .male
                    }

                    LBGenderButton(gender: .female, isActive: viewModel.childGender == .female) {
                        viewModel.childGender = .female
                    }
                }
                .padding(.top, 2)
            }.padding([.trailing,.leading], 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding([.top],16)
        .locbookToolbar(
            title: props.title,
            onClose: { props.onClose?() }
        )
        
    }
}

extension ChildProfileView.Props: Hashable {
    static func == (lhs: ChildProfileView.Props, rhs: ChildProfileView.Props) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    ChildProfileView(props: ChildProfileView.Props(), childName: "Nome da criança")
}

