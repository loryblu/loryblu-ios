import Foundation
import SwiftUI

struct LBAnimatedButtonModifier: ViewModifier {
    @State var isPressed = false
    let action: () -> Void
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = true
                }
                Task {
                    try? await Task.sleep(nanoseconds: 7_500_000_000)
                }
                withAnimation {
                    isPressed = false
                }
                action()
            }.scaleEffect(isPressed ? 1.05 : 1.0)
    }
}

extension View {
    func animationOnPressed(action: @escaping () -> Void = {}) -> some View {
        modifier(LBAnimatedButtonModifier(action: action))
    }
}
