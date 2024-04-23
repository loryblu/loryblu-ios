import Foundation
import SwiftUI

struct LBCategoryButton: View {
    let title: String?
    let isClickable: Bool
    let onClick: () -> Void
    var body: some View {
            ZStack {
                Text(title ?? String())
                    .padding(6)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .font(LBFont.subtitle)
                    .padding(6)
            }
            .background(LBColor.buttonBackgroundDark)
            .cornerRadius(6)
            .foregroundColor(.white)
            .if(isClickable, transform: { view in
                view.animationOnPressed(action: onClick)
            })
    }
}
