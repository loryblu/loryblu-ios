import SwiftUI

struct LocbookActionsView: View {
    
    // MARK: - Definitions
    
    struct Props {
        var task: LocbookTask
        let onNext: ClosureType.LocbookTaskVoid?
    }
    
    // MARK: - Private propertes
    
    private let model = LocbookActionModel()
    
    // MARK: - Properties
    
    let props: Props
    @State var formConfig = FormConfig()
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack {
                Text("<")
                Text(LBStrings.Locbook.title)
                    .font(LBFont.titleAction)
                    .foregroundStyle(LBColor.titlePrimary)

                Spacer()
            }

            LBIcon.progression1.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, minHeight: 40)

            HStack {
                Text(LBStrings.Locbook.actionTitle)
                    .font(LBFont.buttonSmall)
                    .foregroundStyle(LBColor.titlePrimary)
                Spacer()
            }

            actions

            LBButton(title: LBStrings.General.next, style: .primaryActivated) {                
                props.onNext?(formConfig.task)
            }
            .padding(.top, 15)
        }
        .padding(24)
    }


    var actions: some View {
        VStack(spacing: 24) {
            Group {
                ForEach(0..<model.options.count) { index in
                    model.options[index]
                        .overlay(formConfig.selectedCard == index ?
                                 RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0)
                            .strokeBorder(LBColor.titlePrimary, lineWidth: 4) : nil
                        )
                        .opacity(formConfig.selectedCard == index ? 1.0 : 0.5)
                        .onTapGesture {
                            formConfig.selectedCard = index
                            formConfig.task.categoryTitle = model.actions[index].name
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 218)
        }
    }
    
    // MARK: - Initializers
    
    init(props: Props, formConfig: FormConfig = FormConfig()) {
        var config = formConfig
        config.task = props.task
        self.props = props
        self._formConfig = State(initialValue: config)
    }
}

extension LocbookActionsView {
    struct FormConfig {
        var selectedCard: Int? = nil
        var task: LocbookTask = .init()
    }
}

extension LocbookActionsView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}


#Preview {
    LocbookActionsView(props: .init(task: LocbookTask(), onNext: nil))
}
