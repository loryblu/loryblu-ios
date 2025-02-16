import SwiftUI

struct AcessControlPuzzleViewModel: View {
    @State private var number1: Int = 0
    @State private var number2: Int = 0
    @State private var userAnswer: String = ""
    @State private var feedback: String = ""

    var correctAnswer: Int {
        return number1 * number2
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("\(number1) × \(number2) = ?")
                .font(.largeTitle)
                .bold()

            TextField("Digite sua resposta", text: $userAnswer)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Verificar") {
                checkAnswer()
            }
            .buttonStyle(.borderedProminent)

            Text(feedback)
                .font(.title2)
                .foregroundColor(feedback == "Correto! 🎉" ? .green : .red)

            Button("Nova Pergunta") {
                generateNumbers()
                feedback = ""
                userAnswer = ""
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .onAppear {
            generateNumbers()
        }
    }

    /// Gera dois números aleatórios garantindo que o resultado tenha exatamente 2 dígitos (10-99)
    private func generateNumbers() {
        repeat {
            number1 = Int.random(in: 1...9)
            number2 = Int.random(in: 1...9)
        } while (number1 * number2 < 10 || number1 * number2 > 99)
    }

    /// Verifica se a resposta do usuário está correta
    private func checkAnswer() {
        if let userInput = Int(userAnswer), userInput == correctAnswer {
            feedback = "Correto! 🎉"
        } else {
            feedback = "Errado! ❌"
        }
    }
}

#Preview {
    AcessControlPuzzleViewModel()
}
