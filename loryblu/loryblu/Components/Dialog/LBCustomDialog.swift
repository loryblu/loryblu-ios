import SwiftUI

enum Option {
  case option1
  case option2
  case option3
}

struct CustomGroup<Content>: View where Content : View {
    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            content()
        }
        .background(Color.yellow)
        .cornerRadius(8)
    }
}

struct LBCustomDialog<Content> : View where Content : View {

    let title: String = "Deseja excluir a tarefa"
    let firstText: String = "Apenas de"
    let dayOfWeek: String
    let taskName: String
    let message: String = "Este conteúdo será deletado de forma permanente."
    let buttonTitle: String
    let action: ()-> Void = {}
    @State private var offset: CGFloat = 1000
    @State var selectedOption: Option? = .option2

    init(dayOfWeek: String, taskName: String) {
        self.taskName = taskName
        self.dayOfWeek = dayOfWeek
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.title2)
                    .bold()

                Text(taskName)
                    .font(.title2)
                    .bold()
                Spacer(minLength: 16)
                
                Text(message)
                    .font(.system(size: 12, weight: .regular))
                    .padding(24)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 16)
                VStack(alignment: .listRowSeparatorLeading) {
                    LBRadioButton(tag: .option1, selection: $selectedOption, label: "Apenas de `dia`")
                    LBRadioButton(tag: .option2, selection: $selectedOption, label: "Todos os dias")
                }
                .frame(maxWidth: .infinity, alignment: .leading)


                Button {
                    action()
                    close()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.red)

                        Text(buttonTitle)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .padding(16)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
        }
    }
}

#Preview {
    LBCustomDialog(title:"Deseja excluir a tarefa", taskName: "Escovar os dentes ?",message: "Este conteúdo será deletado de forma permanente.", buttonTitle: "Button Text", action: { })
}
