//
//  LoryBluToolbarItem.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 28/01/24.
//
import SwiftUI

struct LoryBluToolBarItem: ToolbarContent {
    
    let title: String
    var onClose : () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some ToolbarContent {
        
        ToolbarItemGroup(placement: .navigationBarLeading) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    
                    Image(LBIcon.arrowBack.rawValue)
                    
                }.frame(alignment: .topLeading)
                    .padding(.leading, 16.0)
                
                Text(title)
                    .font(LBFont.titleAction)
                    .foregroundStyle(LBColor.titlePrimary).padding(.leading, 8.0)
            }.padding(.top,16.0)
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            
            Button {
                
                onClose()
                
            } label: {
                
                Image(LBIcon.close2.rawValue)
                    .resizable()
                    .frame(width: 12, height: 12)
                
            }.frame(alignment: .topLeading).padding(.trailing, 24.0).padding(.top,16.0)
            
        }
    }
}

struct LoryBluToolBarModifier: ViewModifier {

    let title: String
    var onClose : () -> Void

    func body(content: Content) -> some View {
        return content
            .toolbar {
                LoryBluToolBarItem(title: title, onClose : { onClose() })
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func locbookToolbar(title: String, onClose: @escaping ()-> Void) -> some View {
        return self.modifier(LoryBluToolBarModifier(title: title, onClose : onClose))
    }
}

