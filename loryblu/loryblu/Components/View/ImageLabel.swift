import SwiftUI

enum Segment {
    case home
    case locbook
}

struct ImageLabel: View {
    let image: String
    let name: String
    let font: Font
    let segment: Segment
    let select: Bool = false

    var body: some View {
        VStack {
            Spacer()
            GeometryReader { proxy in
                let size = min(proxy.size.width, proxy.size.height)

                VStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            Text(name)
                .multilineTextAlignment(.center)
                .font(font)
                .foregroundStyle(LBColor.background)
                .frame(maxWidth: .infinity, minHeight: 45)
                .background(
                    segment == .home ? LBColor.borderImagetrails : LBColor.backgroundCardsText)
        }
        .background(segment == .home ? LBColor.backgroundImagetrails : LBColor.backgroundCards)
        .cornerRadius(12)
    }
}

#Preview {
    ImageLabel(image: LBIcon.dailyRotine.rawValue, name: LBStrings.Locbook.NameImage.therapist, font: LBFont.titleAction, segment: .home)
}
