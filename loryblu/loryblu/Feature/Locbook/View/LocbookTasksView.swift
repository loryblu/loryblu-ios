import SwiftUI

struct LocbookTasksView: View {
    
    struct Props {
        var onNext: ClosureType.VoidVoid?
    }
    
    struct FormConfig {
        var selectedCard: Int?
    }
    
    let props: Props
    @State var formConfig: FormConfig = FormConfig()

    let tasks: [ImageLabel] = LocbookListTasks.rotine

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("<")
                Text(LBStrings.Locbook.titleStudy)
                    .font(LBFont.titleAction)
                    .foregroundStyle(LBColor.titlePrimary)
                Spacer()
            }

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
        .padding(24)

    }

    var collectionView: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 24 ) {
                ForEach(0..<tasks.count) { index in
                    tasks[index]
                        .overlay(formConfig.selectedCard == index ?
                                 RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0)
                            .strokeBorder(LBColor.titlePrimary, lineWidth: 4) : nil)
                        .opacity(formConfig.selectedCard == index ? 1.0 : 0.5)
                        .onTapGesture {
                            self.formConfig.selectedCard = index
                        }
                }
                .frame(minWidth: 148 , minHeight: 156)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 24)

            LBButton(title: LBStrings.General.next, style: .primaryActivated) {
                props.onNext?()
            }
        } 
        .scrollContentBackground(.hidden)
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
    LocbookTasksView(props: .init())
}
