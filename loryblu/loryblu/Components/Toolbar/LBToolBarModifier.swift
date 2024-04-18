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
    private func showCloseBtnOrNot(addOrEdit: AddOrEditType) -> Bool {
        if addOrEdit == .edit {
            return false
        } else {
            return true
        }
    }
    func locbookToolbar(
        title: String,
        showCloseButton: Bool = true,
        addOrEdit: AddOrEditType = .add,
        onClose: @escaping () -> Void = {}) -> some View {
        let showCloseButtonAdapted = showCloseBtnOrNot(addOrEdit: addOrEdit) && showCloseButton
        return self.modifier(LBToolBarModifier(title: title, showCloseButton: showCloseButtonAdapted, onClose: onClose))}
}
