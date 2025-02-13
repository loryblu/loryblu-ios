import SwiftUI

enum DeleteOption {
  case currentDay
  case allDays
}

struct LBDeleteTaskDialog: View {
    let dayOfWeek: String
    let taskName: String
    let onDelete: (DeleteOption) -> Void
    let onCancel: () -> Void
    @State var selectedOption: DeleteOption? = .allDays

    var body: some View {
        LBCustomDialog(dismiss: onCancel) {
            Text(LBStrings.Dialog.deleteTaskTitle)
                .font(LBFont.button)

            HStack {
                Text(taskName)
                    .font(LBFont.button)
                    .foregroundColor(LBColor.titlePrimary)
                    .multilineTextAlignment(.center)
                Text(LBStrings.General.questionMark)
                    .font(LBFont.button)
                    .multilineTextAlignment(.center)
            }

            Spacer(minLength: 16)
            Text(LBStrings.Dialog.warning)
                .font(LBFont.bodySmall)
                .padding(24)
                .multilineTextAlignment(.center)

            Spacer(minLength: 16)
            VStack(alignment: .listRowSeparatorLeading) {
                LBRadioButton(tag: .currentDay, selection: $selectedOption) {
                    Text(LBStrings.Dialog.deleteOnlyForOneday)
                        .font(LBFont.bodySmall)
                    Text(dayOfWeek)
                        .font(LBFont.buttonSmall)
                }

                LBRadioButton(tag: .allDays, selection: $selectedOption) {
                    Text(LBStrings.Dialog.deleteForAllDays)
                        .font(LBFont.bodySmall)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 24)
            HStack {
                LBButton(title: LBStrings.General.cancel, style: .cancel, isUppercased: false) {
                    onCancel()
                }

                Spacer()
                LBButton(
                    title: LBStrings.Dialog.deleteTitleBtn,
                    style: .error) {
                        onDelete(selectedOption ?? .allDays)
                    }
            }
            .padding(16)
        }
    }

}

#Preview {
    LBDeleteTaskDialog(
        dayOfWeek: LBStrings.DaysOfWeek.monday,
        taskName: LBStrings.NameImage.tvgame,
        onDelete: {_ in },
        onCancel: {})
}
