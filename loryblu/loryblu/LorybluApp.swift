import SwiftUI

@main
struct LorybluApp: App {
    @StateObject private var appData: AppData = .init()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(appData)
                    .onOpenURL { url in
                        let deepLinkHandler = DeepLinkHandler()
                        deepLinkHandler.handleDeepLink(with: url, appData: appData)
                    }
            }
        }
    }
}
