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
    var isSelected: Bool
}

struct LBShiftItemsComponent: View {
    
    let shifts: [ShiftItem]

    var body: some View {
        HStack {
            ForEach(shifts, id: \.name) { shift in
                if shift.isSelected {
                    LBSelectedItemShift(shiftName: shift.name,iconValue: shift.icon)
                } else {
                    Spacer().frame(width: 2)
                    Text(shift.name)
                        .font(LBFont.bodyLarge)
                        .foregroundColor(.gray)
                        .padding(8)
                    Spacer().frame(width: 8)
                }
            }
        }
        .background(LBColor.textfield)
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LBShiftItemsComponent(shifts: [
        ShiftItem(name: "Manhã", icon: LBIcon.sunSmall.rawValue, isSelected: true),
        ShiftItem(name: "Tarde", icon: LBIcon.eviningSmall.rawValue, isSelected: false),
        ShiftItem(name: "Noite", icon: LBIcon.moonSmall.rawValue, isSelected: false)])
}
