import SwiftUI

struct LocbookTasksView: View {
    var title: String = LBStrings.Locbook.titleStudy
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
            LazyVGrid(columns: columns, alignment: .center, spacing: 16 ) {
                ForEach(0..<10, id: \.self) { _ in
                    ImageLabel(image: LBIcon.bathTime.rawValue, name: LBStrings.Locbook.NameImage.loryRotine, backImage: LBColor.backgroundImageLogbook, borderImage: LBColor.borderImageLogbook, font: LBFont.titleTask)
                        .frame(maxWidth: .infinity, minHeight: 155)


                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .padding(.bottom, 24)

            LBButton(
                title: LBStrings.General.next,
                style: .primaryActivated) {
                    //
                }

        } 
        .scrollContentBackground(.hidden)
    }

}

#Preview {
    LocbookTasksView()
}
