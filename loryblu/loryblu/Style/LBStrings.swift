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

extension LBStrings {
    enum Locbook {
        static let title = String(localized: "locbook_title")
        static let button = String(localized: "locbook_button")
        static let actionTitle = String(localized: "locbook_action_title")
        static let taskTitle = String(localized: "locbook_task_title")
        static let checklistTitle = String(localized: "locbook_checklist_title")
        static let shiftTitle = String(localized: "locbook_checklist_shift")
        static let frequencTitle = String(localized: "locbook_checklist_frequency_title")
        static let frequencyText = String(localized: "locbook_checklist_frequency")

        enum NameImage {
            static let loryStudy = String(localized: "image_action_study")
            static let loryRotine = String(localized: "image_action_rotine")
            static let bathTime = String(localized: "image_bathTime")
            static let brushTeeth = String(localized: "image_brushTeeth")
            static let breakfast = String(localized: "image_breakfast")
            static let lunch = String(localized: "image_lunch")
            static let snack = String(localized: "image_snack")
            static let dinner = String(localized: "image_dinner")
            static let water = String(localized: "image_water")
            static let play = String(localized: "image_play")
            static let watchTv = String(localized: "image_watchtv")
            static let tvgame = String(localized: "image_tvgame")
            static let school = String(localized: "image_school")
            static let reinforcement = String(localized: "image_reinforcement")
            static let languages = String(localized: "image_languages")
            static let sport = String(localized: "image_sport")
            static let reading = String(localized: "image_reading")
            static let music = String(localized: "image_music")
            static let psychologist = String(localized: "image_psychologist")
            static let speechTherapist = String(localized: "image_speech_therapist")
            static let pedagogue = String(localized: "image_pedagogue")
            static let therapist = String(localized: "image_occupational_therapist")
<<<<<<< HEAD
            static let morning = String(localized: "image_morning")
=======
            static let morning = String(localized: "iamge_morning")
>>>>>>> 82a2bb3 (Add texts the label the imagems in LBStrings.)
            static let afternoon = String(localized: "image_afternoon")
            static let night = String(localized: "image_night")
        }
    }
}
