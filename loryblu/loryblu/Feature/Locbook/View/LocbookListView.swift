import SwiftUI

struct LocbookListView: View {

    struct Props {
        var task: [TaskRequest]
    }

    init(props: Props, formConfig: FormConfig = FormConfig(),card: CardTaskRegistered) {
        self.card = card
        var config = formConfig
        config.task = props.task
        self.props = props
        self._formConfig = State(initialValue: config)
    }

    var props: Props
    @State var formConfig = FormConfig()
    var model = LocbookListModel()
    var card: CardTaskRegistered

    var body: some View {
        VStack {
            LBWeekDaysButton(sunday: $formConfig.sunday,
                             monday: $formConfig.monday,
                             tuesday: $formConfig.tuesday,
                             wednesday: $formConfig.wednesday,
                             thurday: $formConfig.thurday,
                             friday: $formConfig.friday,
                             satuday: $formConfig.saturday)
            .padding(20)
        }
        .onAppear {
            Task {
                formConfig.task = try await model.loadTask(with:["sat","mon"])
            }
        }
    }


    var list: some View {
        VStack {
            List {
                Button("Oi "){

                }
            }
        }
    }
}

#Preview {
    LocbookListView(props: .init(task: [TaskRequest]()), card:CardTaskRegistered(nameAction: LBStrings.Locbook.titleRotine, imageTask: LBIcon.bathTime.rawValue, nameTask: LBStrings.NameImage.bathTime, backgroundCard: LBColor.buttonGenderEnable, isSecurity: .constant(true)))
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
        var task: [TaskRequest] = []
    }
}
