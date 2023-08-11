import SwiftUI

enum LBIcon: String {
    case agree
    case cake
    case check
    case close
    case eyeClose = "eye_close"
    case eyeOpen = "eye_open"
    case facebook
    case google
    case lock
    case logo
    case loryblu
    case mail
    case man
    case mangray
    case noAgree = "no_agree"
    case search
    case user
    case woman
    case womangray

    var image: Image {
        Image(self.rawValue)
    }
}
