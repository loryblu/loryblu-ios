import SwiftUI

struct LocbookListView: View {

    @State var formConfig = FormConfig()
    var model = LocbookListModel()
    var taskRotine: [Routine] = []

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
            if let taskStudy = formConfig.task?.data?.study {
                ForEach(taskStudy) { task in
                    model.configCardStudy(with: task)
                }
            }

            if let taskRoutine = formConfig.task?.data?.routine {
                ForEach(taskRoutine) { task in
                    model.configCardRoutine(with: task)
                }
            }
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
