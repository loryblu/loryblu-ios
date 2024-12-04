import SwiftUI

struct MenuResponsibleEditView: View {
    let image: Image
    @Binding var user: User
    var body: some View {
        VStack {
            HStack {
                imageDefault
            }
            .frame(maxWidth: .infinity)
            .frame(height: 148)
            .background(LBColor.textfield)
            .padding(.bottom, 50)

            VStack(alignment: .leading) {
                Text("Nome da pessoa responsável")
                    .font(LBFont.buttonSmall)
                LBTextField(style: .common,
                            icon: LBIcon.user,
                            title: "" ,
                            text: $user.parentName,
                            textFiledState: .disable)
                .padding(.bottom, 30)

                Text("E-mail")
                    .font(LBFont.buttonSmall)
                LBTextField(style: .common,
                            icon: LBIcon.mail,
                            title: "",
                            text: $user.parentName,
                            textFiledState: .disable)
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                        .frame(width: 15, height: 15)
                    Text("Náo é possivel editar o e-mail. ")
                        .font(.caption2) +                    Text("Entre em Contato")
                        .bold()
                        .font(.caption2)
                        .underline() +
                    Text(" com o nosso suporte para mais informações")
                        .font(.caption2)
                }
                .padding(.top, 10)
                .padding(.bottom, 20)

                Text("Senha")
                    .font(LBFont.buttonSmall)
                LBTextField(style: .password,
                            icon: LBIcon.lock,
                            title: "",
                            text: $user.parentName,
                            textFiledState: .active)
                .padding(.bottom, 20)

                HStack {
                    LBButton(title: "Cancelar") {

                    }

                    LBButton(title: "Salvar") {
                        
                    }
                }
            }
            .padding()
        }
    }

    var imageDefault: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 96, height: 96)
                .padding()
            image
                .frame(width: 79, height: 79)
        }
    }
}

#Preview {
    MenuResponsibleEditView(image: LBIcon.parentsTree2.image,
                            user: .constant(User(
                                                parentName: "Rodrigo Silva",
                                                childrens: [Child(
                                                    id: 01,
                                                    fullname: "Zeider Silva",
                                                    gender: "male",
                                                    birthdate: "27/01/2020"
                                                )]))
                            )

}
