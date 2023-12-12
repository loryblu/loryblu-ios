import SwiftUI

struct DoneView: View {
    let message: String
    var onClose: () -> Void

    @Environment(\.dismiss) var dismiss

    private let spacing = 50.0

    var body: some View {
        VStack {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Button {
                            onClose()
                            dismiss()
                        } label: {
                            Image(LBIcon.close2.rawValue)
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        .padding(.bottom ,142)
                    }
                    Text(message)
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
struct DoneView_Previews: PreviewProvider {
    static var previews: some View {
        DoneView(message: LBStrings.Register.registerFinishedSuccess) {
            print("Apertei o botão de fechar")
        }
    }
}
