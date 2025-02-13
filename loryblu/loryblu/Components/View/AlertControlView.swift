//
//  AlertControlView.swift
//  LoryBlu
//
//  Created by Suh on 12/02/25.
//

import SwiftUI

struct AlertControlView: View {
    let dayOfWeek: String
    let taskName: String
    let onCancel: () -> Void

    var body: some View {
        LBCustomDialog(dismiss: onCancel) {
            HStack(spacing: 32) {
                Text(LBStrings.Dialog.deleteTaskTitle)
                    .font(LBFont.button)
                    .foregroundColor(LBColor.titlePrimary)
                
                LBIcon.close3.image
            }

            Spacer(minLength: 16)
            Text(LBStrings.AccessControl.infoModal)
                .font(LBFont.bodySmall)
                .padding(24)
                .multilineTextAlignment(.center)

            Spacer(minLength: 24)
            LBButton(title: "conferir", style: .primaryActivated, isUppercased: false) {
                onCancel()
            }
            .padding(16)
        }
    }

}

#Preview {
    AlertControlView(
        dayOfWeek: LBStrings.DaysOfWeek.monday,
        taskName: LBStrings.NameImage.tvgame,
        onCancel: {})
}
