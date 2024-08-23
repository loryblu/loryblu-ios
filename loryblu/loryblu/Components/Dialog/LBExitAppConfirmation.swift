import SwiftUI

struct LBExitAppConfirmation: View {
    let onClosed: () -> Void
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.3)
            VStack {
                VStack {
                    Text("Tem certeza que deseja")
                        .font(LBFont.button)
                        .bold()
                    HStack(spacing:1) {
                        Text("Sair do App")
                            .font(LBFont.button)
                            .bold()
                            .foregroundStyle(LBColor.titlePrimary)
                        Text(LBStrings.General.questionMark)
                            .font(LBFont.button)
                            .bold()
                    }
                }
                .padding()
                HStack(spacing: 20) {
                    Button(action: {

                    }, label: {
                        Text(LBStrings.General.cancel)
                            .foregroundStyle(.black)
                })

                    LBButton(title: "Sair", style: .error) {

                    }
                    .frame(width: 96,height: 34)
                }
                .padding()
            }
            .background(LBColor.textfield)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .frame(width: 240, height: 182)
        }
        .zIndex(1)
        .ignoresSafeArea()

    }
}

#Preview {
    LBExitAppConfirmation(onClosed: { })
}
