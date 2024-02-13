import SwiftUI

struct EditTaskButton: ButtonStyle {
    let image: String

    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Image(image)
                .frame(width: 24, height: 24)

            configuration.label
                .font(LBFont.caption)
                .foregroundStyle(LBColor.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.leading)

        }
        .background(LBColor.textfield)
        .cornerRadius(8)
        .frame(maxWidth: 100, maxHeight: 32)

    }

}

struct EditTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        @State var selected: Bool = true

        VStack {
            Spacer()

            HStack {
                Button("EXCLUIR") {}
                .buttonStyle(
                    EditTaskButton(image: LBIcon.trash.rawValue)
                )
            }
            .frame(height: 32)
            .padding()

            Spacer()
        }
    }
}
