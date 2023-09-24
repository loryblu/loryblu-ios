import Foundation
import SwiftUI

class ResetPasswordModel: ObservableObject {
    @Published var isValid: Bool = false
    var service = RecoveryPasswordService()
    func login(user: String) {
        service.recoveryPassword(with: user) { sucess in
            if let message = sucess?.message {
                self.isValid = true
            } else {
                self.isValid = false
            }
        }
    }
}
