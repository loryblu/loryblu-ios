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
                    Text(shift.name)
                        .font(LBFont.bodyLarge)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity,alignment: .center).padding(2)
                }
            }
        }.background(LBColor.textfield).cornerRadius(8).frame(maxWidth:.infinity,alignment: .center)
    }
}

#Preview {
    LBShiftItemsComponent(shifts: [
        ShiftItem(name: "Manhã", icon: LBIcon.shift_morning.rawValue, isSelected: true),
        ShiftItem(name: "Tarde", icon: LBIcon.shift_morning.rawValue, isSelected: false),
        ShiftItem(name: "Noite", icon: LBIcon.shift_morning.rawValue, isSelected: false)])
}
