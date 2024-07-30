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
                .font(.title2)
                .bold()
            HStack {
                Text(taskName)
                    .font(.title2)
                    .bold()
                    .foregroundColor(LBColor.titlePrimary)
                    .multilineTextAlignment(.center)
                Text(LBStrings.General.questionMark)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            Spacer(minLength: 16)
            Text(LBStrings.Dialog.warning)
                .font(.system(size: 12, weight: .regular))
                .padding(24)
                .multilineTextAlignment(.center)
            Spacer(minLength: 16)
            VStack(alignment: .listRowSeparatorLeading) {
                LBRadioButton(tag: .currentDay, selection: $selectedOption) {
                    Text(LBStrings.Dialog.deleteOnlyForOneday)
                    Text(dayOfWeek).bold()
                }
                LBRadioButton(tag: .allDays, selection: $selectedOption) {
                    Text(LBStrings.Dialog.deleteForAllDays)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 24)

            HStack {
                Button {
                   onCancel()
                } label: {
                    Text(LBStrings.General.cancel).foregroundColor(Color.black)
                }
                .contentShape(Rectangle())
                Spacer().frame(maxWidth: .infinity)
                LBButton(title: LBStrings.Dialog.deleteTitleBtn, style: .error) {
                    onDelete(selectedOption ?? .allDays)
                }
            }.padding(16)
        }
    }

}

#Preview {
    LBDeleteTaskDialog(dayOfWeek: LBStrings.DaysOfWeek.monday, taskName: LBStrings.NameImage.tvgame, onDelete: {_ in }, onCancel: { })
}
