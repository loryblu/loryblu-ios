import SwiftUI

struct LocbookTasksView: View {
        
    struct Props {
        enum ActionType {
            case study
            case routine
        }
        
        let task: LocbookTask
        let actionType: ActionType
        var onNext: ClosureType.LocbookTaskVoid?
        var onClose : ClosureType.VoidVoid?
    }
    
    struct FormConfig {
        var selectedCard: String?
        var task: LocbookTask = .init()
    }
    
    let props: Props
    
    @State var formConfig: FormConfig = FormConfig()

    var tasks: [ImageLabel] {
        switch props.actionType {
        case .study:
            return LocbookListTasks.study
        case .routine:
            return LocbookListTasks.rotine
        }
    }
    
    var title: String {
        switch props.actionType {
        case .study:
            return LBStrings.Locbook.titleStudy
        case .routine:
            return LBStrings.Locbook.titleRotine
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
        .locbookToolbar(title: title, onClose: { props.onClose?() })
        .padding(24)

    }

    var collectionView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 24 ) {
                ForEach(tasks, id: \.uuid) { task in
                    task
                    // Mostrar as tasks de acordo com cada fluxo
                        .overlay(formConfig.selectedCard == task.categoryID ?
                                 RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0)
                            .strokeBorder(LBColor.titlePrimary, lineWidth: 4) : nil)
                        .opacity(formConfig.selectedCard == task.categoryID ? 1.0 : 0.5)
                        .onTapGesture {
                            self.formConfig.selectedCard = task.categoryID
                        }
                }
                .frame(minWidth: 148 , minHeight: 156)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 24)

            LBButton(title: LBStrings.General.next, style: .primaryActivated) {
                formConfig.task.categoryId = formConfig.selectedCard
                props.onNext?(formConfig.task)
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
  
    LocbookTasksView(props: .init(task: LocbookTask(), actionType: .routine)).locbookToolbar(title: "Title of the task", onClose: { })
}
