import SwiftUI

extension NavigationPath {
    mutating func popToRoot() {
        self = NavigationPath()
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
