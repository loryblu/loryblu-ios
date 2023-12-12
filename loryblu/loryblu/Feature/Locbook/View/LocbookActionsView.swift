import SwiftUI

struct LocbookActionsView: View {
    struct Props {
        var task: LocbookTask
        let onNext: ClosureType.VoidVoid?
    }
    
    let props: Props
    @State var formConfig = FormConfig()
    
    private typealias Localizable = LBStrings.Locbook
    
    let options: [ImageLabel] = [
        ImageLabel(image: LBIcon.dailyStudy.rawValue, name: Localizable.NameImage.loryStudy, font: LBFont.titleAction, segment: .locbook),
        ImageLabel(image: LBIcon.dailyRotine.rawValue, name: Localizable.NameImage.loryRotine, font: LBFont.titleAction, segment: .locbook)
    ]

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack {
                Text("<")
                Text(Localizable.title)
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
                props.onNext?()
            }
            .padding(.top, 15)
        }
        .padding(24)
    }


    var actions: some View {
        VStack(spacing: 24) {
            Group {
                ForEach(0..<options.count) { index in
                    options[index]
                        .overlay(formConfig.selectedCard == index ?
                                 RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0)
                            .strokeBorder(LBColor.titlePrimary, lineWidth: 4) : nil
                        )
                        .opacity(formConfig.selectedCard == index ? 1.0 : 0.5)
                        .onTapGesture {
                            formConfig.selectedCard = index
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 218)
        }
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
