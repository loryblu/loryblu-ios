import SwiftUI

@main
struct LorybluApp: App {
    @UIApplicationDelegateAdaptor(FirebaseHelper.self) var delegate
    
    @StateObject private var appData: AppData = .init()
    var body: some Scene {
        WindowGroup {
            AppEntryPoint()
                .environmentObject(appData)
        }
    }
}
