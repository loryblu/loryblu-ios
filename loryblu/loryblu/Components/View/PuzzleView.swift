//
//  PuzzleView.swift
//  LoryBlu
//
//  Created by Suh on 12/02/25.
//

import SwiftUI
import Factory

struct PuzzleView: View {
    @EnvironmentObject var coordinator: MenuNavigationStack.NavigationCoordinator
    @Environment(\.dismiss) var dismiss
    @State private var number1: Int = 0
    @State private var number2: Int = 0
    @State private var userAnswer: String = ""
    @State private var isWrongAnswer: Bool = false
    @State private var navigateToSuccess = false
    let onCancel: () -> Void

    var correctAnswer: Int {
        return number1 * number2
    }

//    struct Props {
//        var isSecurity: Bool
//        var onClose: ClosureType.VoidVoid?
//    }
//    
//    let props: Props
//
//    init(props: Props) {
//        self.props = props
//    }

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
                        title: isWrongAnswer ? LBStrings.General.tryAgain : LBStrings.General.verify,
                        style: .primaryActivated,
                        isUppercased: false
                    ) {
                        checkAnswer()
                    }
                }.onAppear {
                    generateNumbers()
                }
            }
        }.navigationDestination(isPresented: $navigateToSuccess) {
            DoneView(
                props: .init(
                    message: "PARABÉNS, VOCÊ ACERTOU!🎉 ",
                    onClose: { dismiss() })
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
    PuzzleView( onCancel: {})
}
