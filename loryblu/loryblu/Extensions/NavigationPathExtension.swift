import SwiftUI

extension NavigationPath {
    mutating func popToRoot() {
        self = NavigationPath()
    }
}
