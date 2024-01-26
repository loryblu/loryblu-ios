import SwiftUI

struct LocbookRegisterView: View {
    
    struct Props {
        let onNewTask: ClosureType.VoidVoid?
    }
    
    let props: Props
    
    var body: some View {
        VStack(alignment: .center){
            HStack {
                Text("<")
                Text(LBStrings.Locbook.title)
                    .font(LBFont.titleAction)
                .foregroundStyle(LBColor.titlePrimary)

                Spacer()
            }

            LBIcon.dailyList.image
                .resizable()
                .scaledToFit()
                .padding(.top, 70)

            Text(LBStrings.Locbook.infoText)
                .font(LBFont.head6)
                .foregroundStyle(LBColor.text)
                .padding(.top, 28)

            HStack {
                Spacer()
                LBfloatingButton(
                    text: LBStrings.Locbook.button,
                    icon: LBIcon.plus
                ) {
                    self.props.onNewTask?()
                }
            }.padding(.top, 44)

        }
        .padding(24)
    }
}

extension LocbookRegisterView.Props: Hashable {
    static func == (lhs: LocbookRegisterView.Props, rhs: LocbookRegisterView.Props) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    LocbookRegisterView(props: .init(onNewTask: nil))
}
