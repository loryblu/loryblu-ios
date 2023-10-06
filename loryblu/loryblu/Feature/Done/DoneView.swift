//
//  DoneView.swift
//  LoryBlu
//
//  Created by Suh on 25/09/23.
//

import SwiftUI

struct DoneView: View {
    @Environment(\.dismiss) var dismiss
    var onClose: () -> Void

    init(onClose: @escaping () -> Void ) {
        self.onClose = onClose
    }

    private let spacing = 50.0

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button {
                    onClose()
                    dismiss()
                } label: {
                    Image(LBIcon.close2.rawValue)
                        .resizable()
                        .frame(width: 22, height: 22)
                }.padding(.trailing, 12)
            }

            Spacer()

            VStack(spacing: spacing) {
                Text(LBStrings.General.done)
                    .font(LBFont.head6)
                    .foregroundStyle(LBColor.text)

                Image(LBIcon.done.rawValue)
                    .resizable(resizingMode: .stretch)
                    .frame(width: 150, height: 150)
            }.padding(.top, -spacing)

            Spacer()
        }
        .padding()
    }
}

// #Preview {
//    DoneView {
//        print("Apertei o botão de fechar")
//    }
// }
