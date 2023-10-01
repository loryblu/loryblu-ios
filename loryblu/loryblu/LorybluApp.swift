import SwiftUI

@main
struct LorybluApp: App {
    let link = DeepLinkHandler()
    var isGetURL: Bool
     var body: some Scene {
        WindowGroup {
            NavigationStack {

                ContentView()

            }.onOpenURL { url in
                let link = DeepLinkHandler()
                let view = link.makeNewPasswordScreen(with: url.absoluteString)
            }
        }
    }
}
