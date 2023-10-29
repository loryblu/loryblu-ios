//
//  LBWeekDaysButton.swift
//  LoryBlu
//
//  Created by Rodrigo Eduardo Silva on 28/10/23.
//

import SwiftUI

struct LBWeekDaysButton: View {
    var body: some View {
        let weekDay = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]
        ZStack {
            GeometryReader { geometry in
                let shape = RoundedRectangle(cornerRadius: 12)
                shape.fill().foregroundColor(.blue)

            }
            HStack(spacing: 20) {
                ForEach(weekDay, id: \.self) {
                    Button($0.prefix(1)) {

                    }
                    .font(LBFont.button)
                    .foregroundColor(LBColor.background)
                    .background(LBColor.buttonPrimary)
                }
            }
        }

    }
}

struct LBWeekDaysButton_Previews: PreviewProvider {
    static var previews: some View {
        LBWeekDaysButton()
    }
}
