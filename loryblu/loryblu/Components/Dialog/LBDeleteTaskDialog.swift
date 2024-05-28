import SwiftUI

enum Option {
  case option1
  case option2
}

struct LBDeleteTaskDialog: View {
    let title: String = "Deseja excluir a tarefa"
    let firstText: String = "Apenas de"
    let dayOfWeek: String
    let taskName: String
    let message: String = "Este conteúdo será deletado de forma permanente."
    let buttonTitle: String = " "
    let onDelete: ()-> Void = {}
    let onCancel: ()-> Void = {}
    @State var selectedOption: Option? = .option2

    var body: some View {
        LBCustomDialog {
            Text(title)
                .font(.title2)
                .bold()
            HStack {
                Text(taskName)
                    .font(.title2)
                    .bold()
                    .foregroundColor(LBColor.titlePrimary)
                    .multilineTextAlignment(.center)
                Text("?")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            Spacer(minLength: 16)
            Text(message)
                .font(.system(size: 12, weight: .regular))
                .padding(24)
                .multilineTextAlignment(.center)
            Spacer(minLength: 16)
            VStack(alignment: .listRowSeparatorLeading) {
                LBRadioButton(tag: .option1, selection: $selectedOption) {
                    Text("Apenas de")
                    Text(dayOfWeek).bold()
                }
                LBRadioButton(tag: .option2, selection: $selectedOption) {
                    Text("Todos os dias")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 24)

            HStack {
                Button {
                   onCancel()
                } label: {
                    Text("Cancelar").foregroundColor(Color.black)
                }
                .contentShape(Rectangle())
                Spacer().frame(maxWidth: .infinity)
                LBButton(title: "Excluir", style: .error) {
                    onDelete()
                }
            }.padding(16)
        }
    }

}

#Preview {
    LBDeleteTaskDialog(dayOfWeek: "segunda-feira", taskName: "Vídeo Game Liberado")
}
