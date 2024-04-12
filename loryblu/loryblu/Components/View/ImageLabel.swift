import SwiftUI

enum Segment {
    case home
    case locbook
    case `default`
}

struct ImageLabel: View, Identifiable {
    var id: String {
        uuid.uuidString
    }

    var uuid: UUID = UUID()
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
                        .scaledToFill()
                        .frame(width: size, height: size)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            Text(name)
                .multilineTextAlignment(.center)
                .font(font)
                .foregroundStyle(LBColor.background)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(setBackgroundLabel())
        }
        .background(setBackgroundColor())
        .cornerRadius(12)
    }

    private func setBackgroundColor() -> Color {
        if segment == .home {
             LBColor.backgroundImagetrails
        } else if segment == .locbook {
             LBColor.backgroundCards
        } else {
             Color.clear
        }
    }

    private func setBackgroundLabel() -> Color {
        if segment == .home {
             LBColor.borderImagetrails
        } else if segment == .locbook {
             LBColor.backgroundCardsLabel
        } else {
             Color.clear
        }
    }
}

#Preview {
    ImageLabel(image: LBIcon.dailyStudy.rawValue, name: LBStrings.Locbook.NameImage.therapist, font: LBFont.titleAction, segment: .home)
}
