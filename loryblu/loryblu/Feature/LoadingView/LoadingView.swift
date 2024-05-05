//
//  LoadingView.swift
//  LoryBlu
//
//  Created by Suh on 28/04/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var rotationAngle: Double = 0

    var body: some View {
        VStack {
            Image("loading")
                .resizable()
                .frame(width: 72, height: 72)
                .rotationEffect(.degrees(rotationAngle))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
        }
        .onAppear {
            self.rotationAngle = 360
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LBColor.grayLight.opacity(0.65))
        .ignoresSafeArea()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
