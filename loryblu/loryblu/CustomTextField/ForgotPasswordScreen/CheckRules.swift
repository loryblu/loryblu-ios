import Foundation
import SwiftUI

struct CheckdeRules {

    func checkSize(_ password: String) -> Bool {
        let passwordRegex = ".{8,}"
                let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
                return passwordPredicate.evaluate(with: password)
    }

    func checkUppercase(_ password: String) -> Bool {
            let passwordRegex = "(.*[A-Z])"
            let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            return passwordPredicate.evaluate(with: password)
    }

    func checkLowercase(_ password: String) -> Bool {
           let passwordRegex = "(.*[a-z])"
           let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
           return passwordPredicate.evaluate(with: password)
    }

    func checkNumber(_ password: String) -> Bool {
           let passwordRegex = "(.*\\d)"
           let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
           return passwordPredicate.evaluate(with: password)
    }

    func checkSpecial(_ password: String) -> Bool {
           let passwordRegex = "(.*[@$!%*?&])"
           let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
           return passwordPredicate.evaluate(with: password)
    }

}
