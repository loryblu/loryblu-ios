import SwiftUI

struct LBAlertConfirmation: View {
    let textInfo: String
    let highlightText: String
    let textButtonOne: String
    let textButtonTwo: String
    let onClosed: () -> Void
    let onCancel: () -> Void
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
            VStack(alignment: .center) {
                VStack {
                    Text(textInfo)
                        .font(LBFont.button)
                        .bold()
                    HStack {
                        Text(highlightText)
                            .font(LBFont.button)
                            .bold()
                            .foregroundStyle(LBColor.titlePrimary)
                        Text(LBStrings.General.questionMark)
                            .font(LBFont.button)
                            .bold()
                    }
                }
                .padding(.init(top: 24, leading: 24, bottom: 30, trailing: 24))

                HStack(spacing: 10) {
                    LBButton(
                        title: textButtonOne,
                        style: .cancel,
                        isUppercased: false,
                        action: {
                            onCancel()
                        }
                    )
                    LBButton(
                        title: textButtonTwo,
                        style: .error,
                        isUppercased: false,
                        action: {
                            onClosed()
                        }
                    )
                }
                .padding(.init(top: 0, leading: 24, bottom: 24, trailing: 24))
            }
            .background(LBColor.textfield)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .frame(width: 280, height: 200)
            .padding(24)
            .offset(x: 0, y: offset)
            .onAppear(perform: {
                withAnimation(.bouncy) {
                    offset = 0
                }
        })
        }
        .zIndex(1)
        .ignoresSafeArea()

    }
}

#Preview {
    LBAlertConfirmation(
        textInfo: LBStrings.Dialog.areYousSure,
        highlightText: LBStrings.Dialog.leaveApp,
        textButtonOne: "Cancelar",
        textButtonTwo: "Sair",
        onClosed: {
        },
        onCancel: {})
}
