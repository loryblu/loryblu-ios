import SwiftUI

enum LBIcon: String {
    case arrowBack = "arrow_back"
    case bathTime = "bath_time"
    case brushTeeth = "brush_teeth"
    case cake
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
    case eviningSmall = "evining_small"
    case eyeClose = "eye_close"
    case eyeOpen = "eye_open"
    case facebook
    case fairy
    case fairyShadow = "fairy_shadow"
    case games
    case gamesShadow = "games_shadow"
    case google
    case headLori = "head_lori"
    case headMenu = "head_menu"
    case language
    case locbook
    case locbookShadow = "locbook_shadow"
    case lock
    case logoAnimal = "logo_animal"
    case logoFull = "logo_full"
    case logoLetter = "logo_letter"
    case logoName = "logo_name"
    case lunch
    case mail
    case man
    case mangray
    case moon
    case moonSmall = "moon_small"
    case morning
    case music
    case noAgree = "no_agree"
    case psychologist
    case play
    case progression1 = "progression_1"
    case progression2 = "progression_2"
    case progression3 = "progression_3"
    case progression4 = "progression_4"
    case plus
    case reading
    case reinforcement
    case school
    case search
    case shift_morning = "shift_morning"
    case shift_afternoon = "shift_afternoon"
    case shift_night = "shift_night"
    case snack
    case speechTherapy = "speech_therapy"
    case sport
    case pedagogue = "pedagogue"
    case sun
    case sunSmall = "sun_small"
    case therapy
    case tvgame
    case user
    case watchtv
    case water
    case woman
    case womangray

    var image: Image {
        Image(self.rawValue)
    }
}
