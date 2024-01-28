import SwiftUI

struct FrequencyButtonStyle: ButtonStyle {
    
    let style: Style
    let image: String
    let selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
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

            configuration.label
                .multilineTextAlignment(.center)
                .font(LBFont.titleTask)
                .foregroundStyle(LBColor.background)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(style.backgroundLabel(selected: selected))
        }
        .background(style.backgroundColor(selected: selected))
        .overlay {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(
                    LBColor.backgroundCardsLabel,
                    lineWidth: selected ? 4.0 : 0.0
                )
        }
        .cornerRadius(12)
    }
}

extension FrequencyButtonStyle {
    enum Style {
        case light
        case medium
        case dark
        
        func backgroundColor(selected: Bool) -> Color {
            guard selected else {
                return LBColor.grayLight
            }
            
            switch self {
            case .light:
                return LBColor.buttonBackgroundLight
            case .medium:
                return LBColor.buttonBackgroundMedium
            case .dark:
                return LBColor.buttonBackgroundDark
            }
        }
        
        func backgroundLabel(selected: Bool) -> Color {
            if selected {
                return LBColor.backgroundCardsLabel
            }
            
            return LBColor.backgroundCardsLabelDisable
        }
    }
}

// MARK: - Preview

struct FrequencyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        @State var selected: Bool = true

        VStack {
            Spacer()
            
            HStack {
                Button("Button") {
                    selected.toggle()
                }
                .buttonStyle(
                    FrequencyButtonStyle(
                        style: .light,
                        image: LBIcon.dailyStudy.rawValue,
                        selected: selected
                    )
                )
            }
            .frame(height: 280)
            .padding()
            
            Spacer()
        }
    }
}
