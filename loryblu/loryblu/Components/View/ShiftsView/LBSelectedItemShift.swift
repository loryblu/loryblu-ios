//
//  LBSelectedItemShift.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 05/02/24.
//

import SwiftUI

struct LBSelectedItemShift: View {
    
    let shiftName: String
    let iconValue: String
    
    var body: some View {
        HStack {
            Spacer().frame(width: 16)
            Image(iconValue)
            Spacer().frame(width: 4)
            Text(shiftName)
                .font(LBFont.bodyLarge)
                .foregroundColor(.black)
                .padding(8).fixedSize(horizontal: true, vertical: false).padding(2)
            Spacer().frame(width: 8)
        }.background(LBColor.backgroundCards).cornerRadius(8)
    }
}

#Preview {
    LBSelectedItemShift(shiftName: "Manhã", iconValue: LBIcon.shift_morning.rawValue)
}
