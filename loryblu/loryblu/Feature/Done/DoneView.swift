import SwiftUI

struct DoneView: View {
    @Environment(\.dismiss) var dismiss
    
    struct Props {
        let message: String
        var onClose: ClosureType.VoidVoid?
    }

    let props: Props
    private let spacing = 50.0

    var body: some View {
        VStack {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Button {
                            props.onClose?()
                            dismiss()
                        } label: {
                            Image(LBIcon.close2.rawValue)
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        .padding(.bottom ,142)
                    }
                    
                    Text(props.message)
                        .font(LBFont.head6)
                        .foregroundStyle(LBColor.text)
                        .padding(.bottom, 52)

                    Image(LBIcon.done.rawValue)
                        .resizable(resizingMode: .stretch)
                        .frame(width: 118, height: 111)
                        .padding(.bottom ,344)
                }
        }
        .padding()
        .navigationTitle(LBStrings.General.empty)

    }
}

extension DoneView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

struct DoneView_Previews: PreviewProvider {
    static var previews: some View {
        DoneView(
            props: DoneView.Props(
                message: LBStrings.Register.registerFinishedSuccess,
                onClose: {
                    print("Apertei o botão de fechar")
                }
            )
        )
    }
}
