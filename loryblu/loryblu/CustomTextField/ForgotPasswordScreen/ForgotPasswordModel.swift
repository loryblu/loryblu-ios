import Foundation
import SwiftUI

class ForgotPasswordModel: ObservableObject {
        @Published var isValid: Bool = false

        func login(user: String) {
            if user == "loryblue@gmail.com" {
                isValid = true
            }
        }
}
