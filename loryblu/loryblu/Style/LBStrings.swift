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
        static let confirm = String(localized: "confirm")
        static let email = String(localized: "email")
        static let empty = String(localized: "empty")
        static let hello = String(localized: "hello")
        static let next = String(localized: "next")
        static let password = String(localized: "password")
        static let send = String(localized: "send")
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
        static let agree = String(localized: "register_agree_privacy")
        static let birthDay = String(localized: "register_birthday")
        static let buttonRegister = String(localized: "register_button")
        static let child = String(localized: "register_child")
        static let confirmPassword = String(localized: "register_confirm_password")
        static let errorName = String(localized: "textError_name")
        static let errorEmail = String(localized: "textError_email")
        static let errorPassword = String(localized: "textError_confirm_password")
        static let errorBirthDay = String(localized: "textError_birthday")
        static let errorGender = String(localized: "textError_gender")
        static let errorAgree = String(localized: "textError_agree")
        static let linkAgree = String(localized: "register_link_agree")
        static let man = String(localized: "register_gender_man")
        static let name = String(localized: "register_name")
        static let titleLink = String(localized: "register_link_navigationTitle")
        static let registerFinishedSuccess = String(localized: "register_finished_success")
        static let responsible = String(localized: "register_responsible")
        static let woman = String(localized: "register_gender_woman")
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
        static let newPassword = String(localized: "setPassword_new_password")
        static let repeatPassword = String(localized: "setPassword_repeat_password")
        static let passwordMustbeEqual = String(localized: "setPassword_must_be_equal")
        static let successChangePassword = String(localized: "success_change_password")
        static let failureChangePassword = String(localized: "failure_change_password")
    }
}

extension LBStrings {
    enum Login {
        static let title = String(localized: "login_title")
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

extension LBStrings {
    enum GenderButton {
        static let boy = String(localized: "boy")
        static let girl = String(localized: "girl")
    }
}
