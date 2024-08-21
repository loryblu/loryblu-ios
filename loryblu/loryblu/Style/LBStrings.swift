import Foundation
import SwiftUI

enum LBStrings {}

extension LBStrings {
    enum General {
        static let cancel = String(localized: "cancel")
        static let confirm = String(localized: "confirm")
        static let delete = String(localized: "delete")
        static let edit = String(localized: "edit")
        static let email = String(localized: "email")
        static let empty = String(localized: "empty")
        static let hello = String(localized: "hello")
        static let next = String(localized: "next")
        static let newTask = String(localized: "new_task")
        static let password = String(localized: "password")
        static let send = String(localized: "send")
        static let questionMark = String(localized: "question_mark")
    }
}
extension LBStrings {
    enum Toolbar {
        static let editTaskTitle = String(localized: "toolbar_edit_title")
        static let addTaskTitle = String(localized: "toolbar_add_title")
    }
}

extension LBStrings {
    enum Home {
        static let hello = String(localized: "home_hello")
        static let locbook = String(localized: "home_locbook")
        static let trailHistory = String(localized: "home_trail_history")
        static let trailGames = String(localized: "home_trail_games")
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
        static let actionTitle = String(localized: "locbook_action_title")
        static let button = String(localized: "locbook_button")
        static let checklistTitle = String(localized: "locbook_checklist_title")
        static let frequencTitle = String(localized: "locbook_checklist_frequency_title")
        static let infoText = String(localized: "locbook_text_info")
        static let frequencyText = String(localized: "locbook_checklist_frequency")
        static let shiftTitle = String(localized: "locbook_checklist_shift")
        static let taskTitle = String(localized: "locbook_task_title")
        static let title = String(localized: "locbook_title")
        static let titleRotine = String(localized: "locbook_title_rotine")
        static let titleStudy = String(localized: "locbook_title_study")
    }
}

extension LBStrings {
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
        static let morning = String(localized: "image_morning")
        static let afternoon = String(localized: "image_afternoon")
        static let night = String(localized: "image_night")
    }
}

extension LBStrings {
    enum CategoryID {
        static let bathTime = String(localized: "id_bathTime")
        static let brushTeeth = String(localized: "id_brushTeeth")
        static let breakfast = String(localized: "id_breakfast")
        static let lunch = String(localized: "id_lunch")
        static let snack = String(localized: "id_snack")
        static let dinner = String(localized: "id_dinner")
        static let water = String(localized: "id_water")
        static let play = String(localized: "id_play")
        static let watchTv = String(localized: "id_watchtv")
        static let tvgame = String(localized: "id_tvgame")
        static let school = String(localized: "id_school")
        static let reinforcement = String(localized: "id_reinforcement")
        static let languages = String(localized: "id_languages")
        static let sport = String(localized: "id_sport")
        static let reading = String(localized: "id_reading")
        static let music = String(localized: "id_music")
        static let psychologist = String(localized: "id_psychologist")
        static let speechTherapist = String(localized: "id_speech_therapist")
        static let pedagogue = String(localized: "id_pedagogue")
        static let therapist = String(localized: "id_occupational_therapist")
        static let morning = String(localized: "id_morning")
        static let afternoon = String(localized: "id_afternoon")
        static let night = String(localized: "id_night")
    }
}

extension LBStrings {
    enum FrequencyRotine {
        static let workPeriod = String(localized: "frequency_rotine_work_period")
        static let frequencyRotine = String(localized: "frequency_rotine_frequency")
        static let frequencyDays = String(localized: "frequency_rotine_frequency_days")
        static let morning = String(localized: "morning")
        static let afternoon = String(localized: "afternoon")
        static let night = String(localized: "night")
    }
}

extension LBStrings {
    enum SummaryLocbook {
        static let submitTask = String(localized: "summary_submitTask")
        static let task = String(localized: "summary_task")
        static let shift = String(localized: "summary_shift")
        static let category = String(localized: "summary_category")
        static let frequency = String(localized: "summary_frequency")
        static let topbarTitle = String(localized: "summary_topbar")
        static let frequencyDescription = String(localized: "summary_frequencyDescription")
        static let summaryFinishedNewTaskMessage = String(localized: "summary_finished_new_task_message")
        static let summaryFinishedEditTaskMessage = String(localized: "summary_finished_edit_task_message")
    }
}

extension LBStrings {
     enum Dialog {
         static let taskDelete = String(localized: "dialog_delete_task")
         static let sucessDelete = String(localized: "dialog_success_delete")
         static let deleteTaskTitle = String(localized: "delete_title")
         static let deleteOnlyForOneday = String(localized: "delete_justForOneDayOption")
         static let deleteForAllDays = String(localized: "delete_forAllDaysOption")
         static let warning = String(localized: "delete_warning")
         static let deleteTitleBtn = String(localized: "delete_titleBtn")
     }
}

extension LBStrings {
    enum DaysOfWeek {
        static let sunday = String(localized: "dayOfWeek_sunday")
        static let monday = String(localized: "dayOfWeek_monday")
        static let tuesday = String(localized: "dayOfWeek_tuesday")
        static let wednesday = String(localized: "dayOfWeek_wednesday")
        static let thursday = String(localized: "dayOfWeek_thursday")
        static let friday = String(localized: "dayOfWeek_friday")
        static let saturday = String(localized: "dayOfWeek_saturday")
    }
}

extension LBStrings {
    enum Menu {
        static let menu = String(localized: "profile")
        static let configuration = String(localized: "configuration")
        static let childName = String(localized: "child_name")
        static let parentsName = String(localized: "parents_name")
        static let security = String(localized: "security")
        static let faq = String(localized: "faq")
        static let privacyTerms = String(localized: "privacy_terms")
        static let exit = String(localized: "exit")

    }
}
