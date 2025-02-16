//
//  AlertControlView.swift
//  LoryBlu
//
//  Created by Suh on 12/02/25.
//

import SwiftUI

struct AlertControlView: View {@EnvironmentObject var coordinator: MenuNavigationStack.NavigationCoordinator
    @State private var number1: Int = 0
    @State private var number2: Int = 0
    @State private var userAnswer: String = ""
    @State private var isWrongAnswer: Bool = false
    @State private var navigateToSuccess = false
    let onCancel: () -> Void

    var correctAnswer: Int {
        return number1 * number2
    }

    var body: some View {
        NavigationStack {
            LBCustomDialog(dismiss: onCancel) {
                VStack(spacing: 24) {
                    HStack(spacing: 32) {
                        Text(LBStrings.Menu.security)
                            .font(LBFont.button)
                            .foregroundColor(LBColor.titlePrimary)
                        LBIcon.close3.image
                    }

                    if isWrongAnswer {
                        Spacer()
                        Text(LBStrings.AccessControl.puzzleError)
                            .font(LBFont.button)
                            .foregroundColor(LBColor.buttonPrimary)
                    }

                    Text(LBStrings.AccessControl.puzzleInfo)
                        .font(LBFont.bodySmall)
                        .multilineTextAlignment(.center)

                    HStack(spacing: 10) {
                        Group {
                            Text("\(number1) X \(number2)")

                            TextField("", text: $userAnswer)
                                .keyboardType(.numberPad)
                                .padding()
                                .frame(width: 60, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(isWrongAnswer ? LBColor.error : LBColor.titlePrimary, lineWidth: 2)
                                )

                            if isWrongAnswer {
                                LBIcon.error.image
                            }
                        }
                        .font(LBFont.head6)
                        .foregroundStyle(LBColor.titlePrimary)

                    }

                    LBButton(
                        title: isWrongAnswer ? "Tente novamente" : "Verificar",
                        style: .primaryActivated,
                        isUppercased: false
                    ) {
                        checkAnswer()
                        print("=== RESPOSTA CORRETA 🎉 ===")
                    }
                }.onAppear {
                    generateNumbers()
                }
            }
        }.navigationDestination(isPresented: $navigateToSuccess) {
            DoneView(
                props: .init(message: "PARABÉNS, VOCÊ ACERTOU!🎉 ", onClose: {
                    coordinator.pushAccessControlView(props: .init(isAvaliable: true))
                })
            )
        }
    }

    private func generateNumbers() {
        number1 = Int.random(in: 1...9)
        number2 = Int.random(in: 1...9)
    }

    private func checkAnswer() {
        guard let userInput = Int(userAnswer) else {
            isWrongAnswer = true
            return
        }

        if isWrongAnswer {
            generateNumbers()
            isWrongAnswer.toggle()
            userAnswer = String()
            return
        }
        
        if userInput == correctAnswer {
            isWrongAnswer = false
            navigateToSuccess = true
        } else {
            isWrongAnswer = true
        }
    }
}

#Preview {
    AlertControlView(onCancel: {})
}
