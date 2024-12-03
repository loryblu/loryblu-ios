import SwiftUI

struct MenuResponsibleEditView: View {
    let image: Image
    var body: some View {
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
        .background(LBColor.textfield)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MenuResponsibleEditView(image: LBIcon.parentsTree2.image)
}
