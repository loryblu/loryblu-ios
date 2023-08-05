//
//  LBLocalized.swift
//  LoryBlu
//
//  Created by Suh on 21/07/23.
//

import Foundation
import SwiftUI

enum LBStrings {

}

extension LBStrings {
    enum General {
        static let next = String(localized: "next")
        static let send = String(localized: "send")
        static let hello = String(localized: "hello")
        static let email = String(localized: "email")
        static let password = String(localized: "password")
    }
}

extension LBStrings {
    enum Rules {
        static let title = String(localized: "rule_title")
        static let rule1 = String(localized: "rule1")
        static let rule2 = String(localized: "rule2")
        static let rule3 = String(localized: "rule3")
        static let rule4 = String(localized: "rule4")
        static let rule5 = String(localized: "rule5")
    }
}

extension LBStrings {
    enum Register {
        static let responsible = String(localized: "register_responsible")
        static let child = String(localized: "register_child")
        static let name = String(localized: "register_name")
        static let confirmPassword = String(localized: "register_confirm_password")
        static let birthDay = String(localized: "register_birthday" )
        static let man = String(localized: "register_gender_man")
        static let woman = String(localized: "register_gender_woman")
        static let buttonRegister = String(localized: "register_button")
        static let agree = String(localized: "register_agree_privacy")
        static let errorName = String(localized: "textError_name")
        static let errorEmail = String(localized: "textError_email")
        static let errorPassord = String(localized: "textError_confirmPassword")
    }
}

extension LBStrings {
    enum SetPassword {
        static let forget = String(localized: "setPassword_forget")
        static let create = String(localized: "setPassword_create")
        static let reset = String(localized: "setPassword_reset")
        static let error = String(localized: "setPassword_error" )
        static let success = String(localized: "setPassword_success")
        static let alert = String(localized: "setPassword_alert" )
        static let buttonReset = String(localized: "setPassword_button_reset")
    }
}


extension LBStrings {
    enum Login {
        static let email = String(localized: "login_email")
        static let password = String(localized: "login_password")
        static let emailNotExists = String(localized: "login_email_not_exists")
        static let requiredField = String(localized: "login_required_field")
        static let enter = String(localized: "login_enter" )
        static let orDivider = String(localized: "login_or_divider")
        static let forgotPassword = String(localized: "login_forgot_password" )
        static let dontHaveAccount = String(localized: "login_dont_have_an_account")
        static let registerNow = String(localized: "login_register_now")
        static let remeber = String(localized: "login_remember")
    }
}
