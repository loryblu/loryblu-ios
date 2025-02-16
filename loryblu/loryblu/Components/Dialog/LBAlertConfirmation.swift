import SwiftUI

struct LBAlertConfirmation: View {
    let onClosed: () -> Void
    let onCancel: () -> Void
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
            VStack {
                VStack {
                    Text(LBStrings.Dialog.areYousSure)
                        .font(LBFont.button)
                        .bold()
                    HStack {
                        Text(LBStrings.Dialog.leaveApp)
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
                        title: LBStrings.General.cancel,
                        style: .cancel,
                        isUppercased: false,
                        action: {
                            onCancel()
                        }
                    )
                    LBButton(
                        title: LBStrings.General.leave,
                        style: .error,
                        isUppercased: false,
                        action: {
                            onClosed()
                        }
                    )
                }
                .padding(.init(top: 0, leading: 8, bottom: 24, trailing: 20))
            }
            .background(LBColor.textfield)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .frame(width: 240, height: 182)
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
    LBAlertConfirmation(onClosed: { }, onCancel: {  })
}
