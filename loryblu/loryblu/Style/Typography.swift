import Foundation
import SwiftUI

extension Style {
    enum Typography {
        static let head1 = Font.custom("Inter-Bold", size: 56)
        static let head2 = Font.custom("Inter-Bold", size: 48)
        static let head3 = Font.custom("Inter-Bold", size: 40)
        static let head4 = Font.custom("Inter-Medium", size: 32)
        static let head5 = Font.custom("Inter-Medium", size: 24)
        static let head6 = Font.custom("Inter-Medium", size: 20)
        static let subtitle = Font.custom("Inter-Medium", size: 16)
        static let body = Font.custom("Inter-Regular", size: 16)
        static let bodySmall = Font.custom("Inter-Regular", size: 14)
        static let bodyLittleSmall = Font.custom("Inter-Regular", size: 10)
        static let bodyLarge = Font.custom("Inter-Regular", size: 18)
        static let buttonSmall = Font.custom("Inter-Bold", size: 14)
        static let button = Font.custom("Inter-Bold", size: 16)
        static let buttonLarge = Font.custom("Inter-Bold", size: 18)
        static let caption = Font.custom("Inter-Bold", size: 12)
    }
}
