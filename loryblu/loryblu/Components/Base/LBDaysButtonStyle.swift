import Foundation
import SwiftUI

struct LBDaysButtonStyle: ButtonStyle {
    var isSet: Bool
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(isSet ? LBColor.buttonGenderEnable : LBColor.backgroundCards)
                .frame(width: 30, height: 30)
            configuration.label
                .font(LBFont.titleTask)
                .foregroundColor(isSet ? LBColor.backgroundCards : LBColor.buttonGenderEnable)
        }
    }
}
