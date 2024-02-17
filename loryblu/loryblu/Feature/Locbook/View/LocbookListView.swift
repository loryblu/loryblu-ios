import SwiftUI

struct LocbookListView: View {

    @State var formConfig = FormConfig()
    var model = LocbookListModel()


    var body: some View {
        VStack {
            taskList
            Button("teste") {
                Task {
                    formConfig.task = try await model.loadTask(with:["sat","wed"])
                }

            }
              LBWeekDaysButton(sunday: $formConfig.sunday,
                             monday: $formConfig.monday,
                             tuesday: $formConfig.tuesday,
                             wednesday: $formConfig.wednesday,
                             thurday: $formConfig.thurday,
                             friday: $formConfig.friday,
                             satuday: $formConfig.saturday)
            .padding(20)
        }
    }

    var taskList: some View {
        List {

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: .constant(true))

            CardTaskRegistered(nameAction: LBStrings.Locbook.titleStudy, imageTask: LBIcon.school.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonBackgroundMedium, isSecurity: .constant(false))
        }
    }
}

#Preview {
    LocbookListView()
}

extension LocbookListView {
    struct FormConfig {
        var sunday: Bool = false
        var monday: Bool = false
        var tuesday: Bool = false
        var wednesday: Bool = false
        var thurday: Bool = false
        var friday: Bool = false
        var saturday: Bool = false
        var morningSet: Bool = true
        var afternoonSet: Bool = false
        var nightSet: Bool = false
        var task: TaskRequest?
    }
}
