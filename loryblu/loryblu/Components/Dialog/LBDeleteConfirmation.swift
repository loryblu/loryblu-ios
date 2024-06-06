import SwiftUI

struct LBDeleteConfirmation: View {
    @Environment(\.dismiss) var dismiss
    let onClose: () -> Void
    let nameTask: String
    let taskDay: String
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
            .opacity(0.5)
                .onTapGesture {
                    dismiss()
                }
            VStack {
                Text(LBStrings.Dialog.taskDelete)
                    .font(LBFont.button)
                    .bold()

                Text(nameTask)
                    .font(LBFont.button)
                    .foregroundColor(LBColor.titlePrimary)
                    .bold()
                    .padding(.bottom, 20)

                Text(LBStrings.Dialog.sucessDelete)
                    .font(LBFont.bodySmall)

                Text(taskDay + "!")
                    .bold()
                    .padding(.bottom, 20)

                LBButton(title: "Fechar") {
                    dismiss()
                }
                .padding(.trailing, 15)
                .padding(.leading, 15)
            }
            .padding(24)
            .background(LBColor.textfield)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .frame(maxWidth: .infinity)
            .padding(24)
            .offset(x: 0, y: offset)
            .onAppear(perform: {
                withAnimation(.bouncy) {
                    offset = 0
                }
        })
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LBDeleteConfirmation(onClose: {

    }, nameTask: "Escovar os dentes", taskDay: "segunda-feira")
}
