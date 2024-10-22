import Foundation
import SwiftUI
import Factory

class MenuViewModel: ObservableObject {
    private let appData = Container.shared.appData()
    @Published var openExitConfirmationDialog: Bool = false

    func openExitConfirmation() {
        openExitConfirmationDialog = !openExitConfirmationDialog
    }

    func logout() {
        appData.logout()
        openExitConfirmationDialog = !openExitConfirmationDialog
    }

    func giveUpToLogout() {
        openExitConfirmationDialog = !openExitConfirmationDialog
    }
}
