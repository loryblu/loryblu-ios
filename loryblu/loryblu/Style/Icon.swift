import SwiftUI

enum Icon: String {
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
    case search
    case user
    case woman

    var image: Image {
        Image(self.rawValue)
    }
}