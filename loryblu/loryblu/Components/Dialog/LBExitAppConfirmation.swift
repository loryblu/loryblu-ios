import SwiftUI

struct LBExitAppConfirmation: View {
    let onClosed: () -> Void
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
            VStack {
                VStack {
                    Text("Tem certeza que deseja")
                        .font(LBFont.button)
                        .bold()
                    HStack {
                        Text("Sair do App")
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
                .padding(.leading,24)

                HStack(spacing: 10){
                    Button(action: {

                    }, label: {
                        Text(LBStrings.General.cancel)
                            .foregroundStyle(.black)
                })
                    .padding()
                    LBButton(title: "Sair", style: .error) {

                    }
                    .padding(.trailing, 8)
                }
                .padding(.leading, 8)
                .padding(.trailing, 8)
                .padding(.bottom, 24)
                

            }
            .background(LBColor.textfield)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .frame(width: 240,height: 182)
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
    LBExitAppConfirmation(onClosed: { })
}
