//
//  ContentView.swift
//  loryblu
//
//  Created by Suh on 13/07/23.
//

import SwiftUI

func nada() -> Void {
    return
}


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
