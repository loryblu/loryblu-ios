import SwiftUI

struct CardTaskRegistered: View {
    let nameAction: String
    let imageTask: String
    let nameTask: String
    let backgroundCard: Color
    let onEdit: () -> Void
    typealias Localizable = LBStrings.General
    @Binding var isSecurity: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Spacer()
                Text(nameAction)
                    .font(LBFont.head6)

                Spacer()
                if isSecurity {
                    Image(LBIcon.reorg.rawValue)
                        .frame(width: 10, height: 16)
                }
            }
            .padding(8)
            .background(LBColor.textfield)

            HStack {
                Image(imageTask)
                if isSecurity {
                    VStack {
                        Button(Localizable.edit) { onEdit() }
                            .buttonStyle(EditTaskButton(image: LBIcon.edit.rawValue))

                        Button(Localizable.delete) {}
                            .buttonStyle(EditTaskButton(image: LBIcon.trash.rawValue)
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
        .frame(maxWidth: .infinity, maxHeight: 207)
    }
}

#Preview {
    VStack {
        CardTaskRegistered(
            nameAction: LBStrings.Locbook.titleRotine,
            imageTask: LBIcon.bathTime.rawValue,
            nameTask: LBStrings.NameImage.bathTime,
            backgroundCard: LBColor.buttonBackgroundLight, onEdit: {},
            isSecurity: .constant(true))
        CardTaskRegistered(
            nameAction: LBStrings.Locbook.titleStudy,
            imageTask: LBIcon.school.rawValue,
            nameTask: LBStrings.NameImage.bathTime,
            backgroundCard: LBColor.buttonBackgroundMedium, onEdit: {},
            isSecurity: .constant(false))
        CardTaskRegistered(
            nameAction: LBStrings.Locbook.titleRotine,
            imageTask: LBIcon.bathTime.rawValue,
            nameTask: LBStrings.NameImage.bathTime,
            backgroundCard: LBColor.buttonGenderEnable, onEdit: {},
            isSecurity: .constant(true))
    }

}
