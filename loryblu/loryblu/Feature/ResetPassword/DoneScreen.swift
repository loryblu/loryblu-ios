//
//  DoneScreen.swift
//  LoryBlu
//
//  Created by Rodrigo Eduardo Silva on 05/10/23.
//

import SwiftUI

struct DoneScreen: View {
    var onClose: () -> Void
        @State var goToLogin: Bool = false

        private let spacing = 50.0
    var body: some View {
         NavigationStack {
                    VStack {
                        HStack {
                            Spacer()

                            Button {
                                goToLogin = true
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
                .navigationTitle(LBStrings.General.empty)
                .navigationDestination(isPresented: $goToLogin) {
                    LoginView()
                        .toolbarRole(.editor)
                        .navigationBarBackButtonHidden(true)
                }
        }
}

struct DoneScreen_Previews: PreviewProvider {
    static var previews: some View {
        DoneScreen()
    }
}
