import SwiftUI

enum LBIcon: String {
    case bathTime = "bath_time"
    case brushTeeth = "brush_teeth"
    case cake
    case calendar
    case calendarShadow = "calendar_shadow"
    case check
    case circle
    case circleFill = "circle_fill"
    case close
    case close2
    case dailyList = "daily_list"
    case dailyRotine = "daily_rotine"
    case dailyStudy = "daily_study"
    case dental
    case dinner
    case done
    case evining
    case eyeClose = "eye_close"
    case eyeOpen = "eye_open"
    case facebook
    case fairy
    case fairyShodow = "fairy_shodow"
    case game
    case google
    case headLori = "head_lori"
    case headMenu = "head_menu"
    case language
    case lock
    case logoAnimal = "logo_animal"
    case logoFull = "logo_full"
    case logoLetter = "logo_letter"
    case logoName = "logo_name"
    case lunch
    case mail
    case man
    case mangray
    case meditation
    case moon
    case morning
    case music
    case noAgree = "no_agree"
    case psychologist
    case play
    case reading
    case reinforcement
    case school
    case search
    case snack
    case speechTherapy = "speech_therapy"
    case sport
    case study
    case sun
    case tvgame
    case tvgameShadow = "tvgame_shadow"
    case user
    case watchtv
    case water
    case woman
    case womangray

    var image: Image {
        Image(self.rawValue)
    }
}
