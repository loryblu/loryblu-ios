import SwiftUI

struct LocbookTasksView: View {
    enum ActionType {
        case study
        case routine
    }

    struct Props {
        let addOrEdit: AddOrEditType
        let task: LocbookTask
        let title: String
        let actionType: ActionType
        var onNext: ClosureType.LocbookTaskVoid?
        var onClose: ClosureType.VoidVoid?
    }

    struct FormConfig {
        var selectedCard: Int?
        var task: LocbookTask = .init()
    }

    let props: Props

    @State var formConfig: FormConfig = FormConfig()
    @State var categoryID: String = ""

    var tasks: [ImageLabel] {
        switch props.actionType {
        case .study:
            return ListTasks.study
        case .routine:
            return ListTasks.rotine
        }
    }

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 20) {
            LBIcon.progression2.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, minHeight: 40)

            HStack {
                Text(LBStrings.Locbook.taskTitle)
                    .font(LBFont.buttonSmall)
                    .foregroundStyle(LBColor.titlePrimary)
                Spacer()
            }

            collectionView
        }
        .onAppear {
            formConfig.task = props.task
        }
        .locbookToolbar(title: props.title, addOrEdit: props.addOrEdit, onClose: { props.onClose?() })
        .padding(24)

    }

    var collectionView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 24 ) {
                ForEach(0..<tasks.count, id: \.self) { index in
                    tasks[index]
                        .overlay(formConfig.selectedCard == index ?
                                 RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0)
                            .strokeBorder(LBColor.titlePrimary, lineWidth: 4) : nil)
                        .opacity(formConfig.selectedCard == index ? 1.0 : 0.5)
                        .animationOnPressed(listContext: true, action: {
                            self.formConfig.selectedCard = index
                            self.formConfig.task.categoryId = tasks[index].categoryID
                            self.formConfig.task.taskTitle = tasks[index].name
                        })
                }
                .frame(minWidth: 148, minHeight: 156)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 24)

            LBButton(title: LBStrings.General.next, style: .primaryActivated) {
                if(formConfig.selectedCard) != nil {
                    props.onNext?(formConfig.task)
                }
                // ENVIAR O categoryID da task e nome. ( task.categoryID / task.name )
            }
        }
        .scrollContentBackground(.hidden)
    }

    init(props: Props, formConfig: FormConfig = FormConfig()) {
        var config = formConfig
        config.task = props.task
        self.props = props
        self._formConfig = State(initialValue: config)
    }
}

extension LocbookTasksView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    LocbookTasksView(
        props: .init(addOrEdit: AddOrEditType.add, task: LocbookTask(), title: "Nova tarefa", actionType: .routine)
    ).locbookToolbar(title: "Title of the task", onClose: {})
}
