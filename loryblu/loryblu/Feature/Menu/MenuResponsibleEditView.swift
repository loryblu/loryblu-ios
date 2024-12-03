import SwiftUI

struct MenuResponsibleEditView: View {
    let image: Image
    @Binding var user: User
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 96, height: 96)
                    .padding()
                    image
                        .frame(width: 79, height: 79)

                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 148)
            .background(LBColor.textfield)

            VStack(alignment:.leading){
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
                            title: "" ,
                            text: $user.parentName,
                            textFiledState: .disable)

                Text("Senha")
                    .font(LBFont.buttonSmall)
                LBTextField(style: .password,
                            icon: LBIcon.lock,
                            title: "" ,
                            text: $user.parentName,
                            textFiledState: .disable)
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
}

extension MenuResponsibleEditView {
    
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
