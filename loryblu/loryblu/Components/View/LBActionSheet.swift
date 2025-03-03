//
//  LBActionSheet.swift
//  LoryBlu
//
//  Created by Suh on 26/02/25.
//

import SwiftUI

struct LBActionSheet: View {
    let image: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            VStack(spacing: 24) {
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.blue)
                        .overlay(RoundedRectangle(cornerRadius: 2, style: .continuous))
                    Spacer()
                    Text("Editar foto de perfil")
                        .font(LBFont.titleTask)
                        .foregroundColor(LBColor.titlePrimary)
                    Spacer()
                    LBIcon.close2.image

                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)

                VStack(spacing: 0) {
                    Button(action: {
                        print("Tira foto")
                        isPresented = false
                    }, label: {
                        HStack {
                            Text("Tirar foto")
                                .font(.headline)
                                .foregroundColor(LBColor.titlePrimary)
                            Spacer()
                            LBIcon.camera.image
                                .frame(width: 32, height: 32)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    })

                    Divider()
                    Button(action: {
                        print("Escolher foto")
                        isPresented = false
                    }, label: {
                        HStack {
                            Text("Escolher foto")
                                .font(.headline)
                                .foregroundColor(LBColor.titlePrimary)
                            Spacer()
                            LBIcon.album.image
                                .frame(width: 32, height: 32)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    })

                    Divider()
                    Button(action: {
                        isPresented = false
                    }, label: {
                        HStack {
                            Text("Excluir foto")
                                .font(.headline)
                                .foregroundColor(LBColor.titlePrimary)
                            Spacer()
                            LBIcon.trashBlue.image
                                .frame(width: 32, height: 32)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    })
                }
                .background(LBColor.blue100)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    ).stroke(LBColor.titlePrimary, lineWidth: 1)
                )
            }
            .background(LBColor.blue100)
            .padding()
            .frame(maxWidth: .infinity)
            .transition(.move(edge: .bottom))

        }
        .padding(.bottom, 16)
        .background(LBColor.blue100)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onTapGesture {
            isPresented = false
        }
    }
}

struct ContentView2: View {
    @State private var showCustomActionSheet = false

    var body: some View {
        VStack {
            Text("Selecione uma ação")
                .padding()

            Button("Mostrar ActionSheet Personalizado") {
                showCustomActionSheet.toggle()
            }
            .padding()
        }
        .overlay(
            showCustomActionSheet ? AnyView(
                LBActionSheet(image: LBIcon.parentsTree.rawValue, isPresented: $showCustomActionSheet)
            ) : AnyView(EmptyView())
        )

    }
}

#Preview {
    ContentView2()
}
