import SwiftUI

struct LBExitAppConfirmation: View {
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
                .padding(.top, 24)
                .padding(.bottom, 30)
                .padding(.trailing, 24)
                .padding(.leading, 24)

                HStack(spacing: 10) {
                    Button(action: {
                        onCancel()
                    }, label: {
                        Text(LBStrings.General.cancel)
                            .foregroundStyle(.black)
                })
                    .padding()
                    Button(action: {
                        onClosed()
                    }, label: {
                        Text(LBStrings.General.leave)
                            .foregroundStyle(.red)
                            .bold()
                    })
                    .frame(height: 34)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(.red, lineWidth: 1)
                    )
                }
                .padding(.leading, 8)
                .padding(.trailing, 20)
                .padding(.bottom, 24)
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
    LBExitAppConfirmation(onClosed: { }, onCancel: {  })
}
