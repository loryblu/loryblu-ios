import SwiftUI

struct LocbookListView: View {

    struct Props {
        var task: LocbookTask
    }

    init(props: Props, formConfig: FormConfig = FormConfig()) {
        var config = formConfig
        config.task = props.task
        self.props = props
        self.props.task.shift = .morning
        self._formConfig = State(initialValue: config)
    }

    var props: Props
    @State var formConfig = FormConfig()

    var body: some View {
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

#Preview {
    LocbookListView(props: .init(task: LocbookTask.init()))
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
        var task: LocbookTask = .init()
    }
}
