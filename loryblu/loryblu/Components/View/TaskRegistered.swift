import SwiftUI

struct TaskRegistered: View {
    let nameAction: String
    let imageTask: String
    let nameTask: String
    let backgroundCard: Color
    @Binding var isSecurity: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Spacer()
                Text(nameAction)
                    .font(LBFont.head6)

                Spacer()
                Image(LBIcon.reorg.rawValue)
                    .frame(width: 10, height: 16)
            }
            .padding(8)
            .background(LBColor.textfield)

            HStack {
                Image(imageTask)

                if isSecurity {
                    VStack {
                        Button("Editar") {
                            //TODO: Chamar tela de ediçãode tarefa.
                        }
                        .buttonStyle(EditTaskButton(image: LBIcon.edit.rawValue))

                        Button("Deletar") {
                            //TODO: Chamar alerta de exclusao de tarefa.
                        }
                        .buttonStyle(
                            EditTaskButton(image: LBIcon.trash.rawValue)
                        )

                    }
                }

            }
            
            Text(nameTask)
                .font(LBFont.titleTask)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(LBColor.textfield)
        }
        .background(backgroundCard)
        .cornerRadius(8)
        .frame(maxWidth: 312, maxHeight: 207)

    }
}

#Preview {
    VStack {
        TaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: .constant(true))

        TaskRegistered(nameAction: LBStrings.Locbook.titleStudy, imageTask: LBIcon.school.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundMedium, isSecurity: .constant(false))

        TaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonGenderEnable, isSecurity: .constant(true))
    }

}
