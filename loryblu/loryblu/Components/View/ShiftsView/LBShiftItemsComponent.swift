//
//  LBShiftItemsComponent.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 05/02/24.
//

import SwiftUI

struct ShiftItem {
    var name: String
    var icon: String
    var backgroundColor: Color
    var letterColor: Color
    var isSelected: Bool
}

struct LBShiftItemsComponent: View {
    
    let shifts: [ShiftItem]
    
    var body: some View {
        HStack {
            ForEach(shifts, id: \.name) { shift in
                if shift.isSelected {
                    LBSelectedItemShift(
                        shiftName: shift.name,
                        iconValue: shift.icon,
                        backgroundColor: shift.backgroundColor,
                        letterColor: shift.letterColor)
                } else {
                    Text(shift.name)
                        .font(LBFont.bodyLarge)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity,alignment: .center).padding(2)
                }
            }
        }
        .background(LBColor.textfield)
        .cornerRadius(8)
        .frame(maxWidth:.infinity,alignment: .center)
    }
}

#Preview {
    LBShiftItemsComponent(shifts: [
        ShiftItem(name: LBStrings.FrequencyRotine.morning, icon: LBIcon.sunSmall.rawValue,backgroundColor: LBColor.buttonBackgroundLight, letterColor: .black,isSelected: true),
        ShiftItem(name: LBStrings.FrequencyRotine.afternoon, icon: LBIcon.eviningSmall.rawValue, backgroundColor: LBColor.buttonBackgroundMedium,letterColor: .white, isSelected: false),
        ShiftItem(name: LBStrings.FrequencyRotine.night, icon: LBIcon.moonSmall.rawValue,backgroundColor: LBColor.buttonBackgroundDark, letterColor: .white,isSelected: false)])
}
