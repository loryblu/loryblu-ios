import SwiftUI

struct LocbookTasksView: View {
    @State private var selectedCard: Int?
    var title: String = LBStrings.Locbook.titleStudy
    let tasks: [ImageLabel] = LocbookListTasks.rotine
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("<")
                Text(title)
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
                        .overlay(selectedCard == index ?
                                 RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0)
                            .strokeBorder(LBColor.titlePrimary, lineWidth: 4) : nil)
                        .opacity(selectedCard == index ? 1.0 : 0.5)
                        .onTapGesture {
                            selectedCard = index
                        }
                }
                .frame(minWidth: 148 , minHeight: 156)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 24)

            LBButton(
                title: LBStrings.General.next,
                style: .primaryActivated) {
                    //
                }

        } 
        .scrollContentBackground(.hidden)
    }

//    private func stateButton() {
//        selectedCard == nil
//    }

}

#Preview {
    LocbookTasksView(title: LBStrings.Locbook.titleStudy)
}
