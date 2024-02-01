//
//  LoryBluToolBarModifier.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 31/01/24.
//

import SwiftUI

struct LBToolBarModifier: ViewModifier {

    let title: String
    var onClose : () -> Void

    func body(content: Content) -> some View {
        return content
            .toolbar {
                LBToolBarItem(title: title, onClose : { onClose() })
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func locbookToolbar(title: String, onClose: @escaping ()-> Void) -> some View {
        return self.modifier(LBToolBarModifier(title: title, onClose : onClose))
    }
}
