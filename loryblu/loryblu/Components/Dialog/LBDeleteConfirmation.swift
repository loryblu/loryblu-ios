import SwiftUI

struct LBDeleteConfirmation: View {
    let onClose: () -> Void
    let nameTask: String
    let taskDay: String
    @State private var offset: CGFloat = 1000

    var body: some View {
        VStack {
            Text("Tarefa deletada:")
                .font(.title3)
                .bold()

            Text(nameTask)
                .font(.title3)
                .foregroundColor(LBColor.titlePrimary)
                .bold()
                .padding(.bottom, 20)

            Text("Deletada com sucesso de")
            Text(taskDay + "!")
                .bold()
            LBButton(title: "Fechar") {
                onClose()
            }
            .padding(10)
        }
        .padding()
        .background(LBColor.textfield)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .frame(maxWidth: .infinity)
        .padding()
        .offset(x:0 ,y: offset)
        .onAppear(perform: {
            withAnimation(.bouncy) {
                offset = 0
            }
        })



    }
}

#Preview {
    LBDeleteConfirmation(onClose: {

    }, nameTask: "Escovar os dente", taskDay: "segunda-feira")
}
