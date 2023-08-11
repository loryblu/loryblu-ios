import SwiftUI
import Foundation

struct LBGendrerButton: View {
    init (gendrer: Gendrer, action: @escaping () -> Void ) {
        self.action = action
        self.gendrer = gendrer
    }
    enum Gendrer {
        case male
        case female
    }
    var gendrer: Gendrer
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                gendrer == .male ? LBIcon.man.image : LBIcon.woman.image
                Text( gendrer == .male ? LBStrings.GendrerButton.boy : LBStrings.GendrerButton.girl)
                    .font(LBFont.bodySmall)
                    .fontWeight(.bold)
            }
                    .padding(10)
                    .foregroundColor(gendrer == .male ? LBColor.background : LBColor.placeholder)
                    .frame(width: 154, height: 44, alignment: .leading)
                    .background( gendrer == .male ? LBColor.darkBlue : LBColor.background)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .inset(by: -1)
                        .stroke( (gendrer == .male ? LBColor.darkBlue : LBColor.placeholder), lineWidth: 2))
        }
    }
}
