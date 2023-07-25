//
//  ValidadeRules.swift
//  LoryBlu
//
//  Created by Suh on 24/07/23.
//

import Foundation
import SwiftUI

struct ValidadeRules {

    func validateName(name: String) -> Bool {
        !name.isEmpty
    }

    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func validatesize(password: String) -> Bool {
        let passwordRegex = ".{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    func validateUppercase(password: String) -> Bool {
        let passwordRegex = "(.*[A-Z])"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    func validateLowercase(password: String) -> Bool {
        let passwordRegex = "(.*[a-z])"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    func validateNumber(password: String) -> Bool {
        let passwordRegex = "(.*\\d)"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    func validateSpecial(password: String) -> Bool {
        let passwordRegex = "(.*[@$!%*?&])"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

}
