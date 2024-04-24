//
//  LoryBluToolBarModifier.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 31/01/24.
//

import SwiftUI

struct LBToolBarModifier: ViewModifier {

    let title: String
    let showCloseButton: Bool
    var onClose: () -> Void

    func body(content: Content) -> some View {
        return content
            .toolbar {
                LBToolBarItem(title: title, showCloseButton: showCloseButton, onClose: { onClose() })
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func locbookToolbar(
        title: String,
        showCloseButton: Bool = true,
        onClose: @escaping () -> Void = {}) -> some View {
        return self.modifier(LBToolBarModifier(title: title, showCloseButton: showCloseButton, onClose: onClose))}
}
