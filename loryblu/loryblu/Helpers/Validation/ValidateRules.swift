//
//  ValidateRules.swift
//  LoryBlu
//
//  Created by Suh on 24/07/23.
//

import Foundation
import SwiftUI

enum ValidateRules {

    static func validateName(_ name: String) -> Bool {
        !name.isEmpty && name.count >= 3
    }

    static func validate(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    static func validateSize(password: String) -> Bool {
        let passwordRegex = ".{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    static func validateUppercase(password: String) -> Bool {
        let passwordRegex = ".*[A-Z].*"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    static func validateLowercase(password: String) -> Bool {
        let passwordRegex = ".*[a-z].*"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    static func validateNumber(password: String) -> Bool {
        let passwordRegex = ".*\\d.*"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    static func validateSpecial(password: String) -> Bool {
        let passwordRegex = ".*[@$#!%*&].*"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

}
