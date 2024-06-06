import SwiftUI

enum Option {
  case option1
  case option2
}

struct LBDeleteTaskDialog: View {
    let dayOfWeek: String
    let taskName: String
    let onDelete: () -> Void = {}
    let onCancel: () -> Void
    @State var selectedOption: Option? = .option2

    var body: some View {
        LBCustomDialog(dismiss: onCancel) {
            Text(LBStrings.DeleteLocbookAction.deleteTaskTitle)
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
            Text(LBStrings.DeleteLocbookAction.warning)
                .font(.system(size: 12, weight: .regular))
                .padding(24)
                .multilineTextAlignment(.center)
            Spacer(minLength: 16)
            VStack(alignment: .listRowSeparatorLeading) {
                LBRadioButton(tag: .option1, selection: $selectedOption) {
                    Text(LBStrings.DeleteLocbookAction.deleteOnlyForOneday)
                    Text(dayOfWeek).bold()
                }
                LBRadioButton(tag: .option2, selection: $selectedOption) {
                    Text(LBStrings.DeleteLocbookAction.deleteForAllDays)
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
                LBButton(title: LBStrings.DeleteLocbookAction.deleteTitleBtn, style: .error) {
                    onDelete()
                }
            }.padding(16)
        }
    }

}

#Preview {
    LBDeleteTaskDialog(dayOfWeek: LBStrings.DaysOfWeek.monday, taskName: LBStrings.NameImage.tvgame, onCancel: { })
}
