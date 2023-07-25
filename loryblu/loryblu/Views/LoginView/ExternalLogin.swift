//
//  ExternalLogin.swift
//  LoryBlu
//
//  Created by Paulo Pinheiro on 7/25/23.
//

import SwiftUI

struct ExternalLogin: View {
    
    var body: some View {
        HStack{
            Button {
            } label: {
                Image("google")
            }
            .padding(.trailing, 48.0)
            
            Button {
                    
            } label: {
                Image("facebook")

            }
            
        }
    }
}

struct ExternalLogin_Previews: PreviewProvider {
    static var previews: some View {
        ExternalLogin()
    }
}
