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
            Spacer()
                .frame(width: 8)
            Image(iconValue)
                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer()
                .frame(width: 2)
            Text(shiftName)
                .font(LBFont.bodyLarge)
                .foregroundColor(.black)
                .padding(8)
            Spacer()
                .frame(width: 8)
        }
        .background(LBColor.backgroundCards)
        .cornerRadius(8)
    }
}

#Preview {
    LBSelectedItemShift(shiftName: "Manhã", iconValue: LBIcon.sunSmall.rawValue)
}
