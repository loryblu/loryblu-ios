import SwiftUI

struct LocbookRegisterView: View {
    var body: some View {
        VStack(alignment: .center){
            HStack {
                Text("<")
                Text(LBStrings.Locbook.title)
                    .font(LBFont.titleAction)
                .foregroundStyle(LBColor.titlePrimary)

                Spacer()
            }

            LBIcon.dailyList.image
                .resizable()
                .scaledToFit()
                .padding(.top, 70)

            Text(LBStrings.Locbook.infoText)
                .font(LBFont.head6)
                .foregroundStyle(LBColor.text)
                .padding(.top, 28)

            HStack {
                Spacer()
                LBfloatingButton(
                    text: LBStrings.Locbook.button,
                    icon: LBIcon.plus
                ) {
                    //
                }
            }.padding(.top, 44)

        }
        .padding(24)
    }
}

#Preview {
    LocbookRegisterView()
}
