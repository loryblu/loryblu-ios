import SwiftUI
import Factory

struct HomeView: View {
    @ObservedObject var model = Container.shared.homeViewModel()
    @State var props: Props
    @Injected(\.appData) var appData

    let traills: [ImageLabel] = [
        ImageLabel(
            image: LBIcon.locbook.rawValue,
            name: LBStrings.Home.locbook,
            font: LBFont.titleAction,
            segment: .home),
        ImageLabel(
            image: LBIcon.fairyShadow.rawValue,
            name: LBStrings.Home.trailHistory,
            font: LBFont.titleAction,
            segment: .home),
        ImageLabel(
            image: LBIcon.gamesShadow.rawValue,
            name: LBStrings.Home.trailGames,
            font: LBFont.titleAction,
            segment: .home)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            header
            trails
        }
    }

    var header: some View {
        HStack(alignment:.top, spacing: 20 ) {
            LBIcon.headMenu.image
                .resizable()
                .scaledToFill()
                .frame(width: 81, height: 78)
            VStack(alignment: .leading) {
                Text("Olá, \(model.childName)")
                    .font(LBFont.body)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(UnevenRoundedRectangle(topLeadingRadius: 14,
                                                        bottomLeadingRadius: 0,
                                                        bottomTrailingRadius: 14,
                                                        topTrailingRadius: 14)
                        .foregroundStyle(LBColor.buttonGenderEnable)
                      )
                Text("Como você está?")
                    .font(LBFont.body)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(UnevenRoundedRectangle(topLeadingRadius: 14,
                                                        bottomLeadingRadius: 0,
                                                        bottomTrailingRadius: 14,
                                                        topTrailingRadius: 14)
                        .foregroundStyle(LBColor.buttonGenderEnable)
                      )
            }
            
            Button(action: {

            }, label: {
                LBIcon.menuButton.image
            })

        }
        .padding(.init(top: 12, leading: 0, bottom: 32, trailing: 0))
    }

    var trails: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 24) {
                Group {
                    ForEach(0..<traills.count) { index in
                        traills[index]
                            .overlay(props.selectedCard == index ?
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0)
                                    .strokeBorder(LBColor.borderImagetrails, lineWidth: 4) : nil
                                )

                            .opacity(props.selectedCard == index ? 1.0 : 0.5)
                            .onTapGesture {
                                props.selectedCard = index
                                if props.selectedCard == 0 {
                                    props.onSelectCard?()
                                }
                            }
                    }
                }
                .frame(width: 312, height: 218)

            }.padding(24)
        }
    }
}

extension HomeView {
    struct Props {
        var selectedCard: Int?
        let onSelectCard: ClosureType.VoidVoid?
    }
}

extension HomeView {
    static func build(onSelectCard: ClosureType.VoidVoid?) -> Self {
        HomeView(props: .init(onSelectCard: onSelectCard))
    }
}

#Preview {
    HomeView(props: .init(onSelectCard: nil))
}
