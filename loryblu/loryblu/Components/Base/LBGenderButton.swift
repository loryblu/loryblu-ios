import SwiftUI
import Foundation

struct LBGenderButton: View {
    init (gendrer: Gender, isActive: Bool = false, action: @escaping () -> Void ) {
        self.action = action
        self.gender = gendrer
        self.isActive = isActive
    }

    enum Gender {
        case male
        case female
    }
    var gender: Gender
    let action: () -> Void
    var isActive: Bool
    var body: some View {
        Button(action: action) {
            HStack {
            gender == .male ? (isActive ? LBIcon.man.image : LBIcon.mangray.image) : (isActive ? LBIcon.woman.image : LBIcon.womangray.image)
                Text( gender == .male ? LBStrings.GenderButton.boy : LBStrings.GenderButton.girl)
                    .font(LBFont.bodySmall)
                    .fontWeight(.bold)
            }
                    .padding(10)
                    .foregroundColor(isActive ? LBColor.background : LBColor.placeholder)
                    .frame(width: 154, height: 44, alignment: .leading)
                    .background( isActive ? LBColor.buttonGenderEnable : LBColor.background)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .inset(by: -1)
                        .stroke( (isActive ? LBColor.buttonGenderEnable : LBColor.placeholder), lineWidth: 2))
        }
    }
}

struct LBGenderButton_Previews: PreviewProvider
{
    static var previews: some View {
        VStack {
            HStack{
                LBGenderButton(gendrer: .male, isActive: true){}
                LBGenderButton(gendrer: .male){}
            }
            HStack {
                LBGenderButton(gendrer: .female, isActive: true){}
                LBGenderButton(gendrer: .female){}
            }
        }
    }
}
