import SwiftUI

@main
struct LorybluApp: App {
    @StateObject private var appData: AppData = .init()
    var body: some Scene {
        WindowGroup {
            AppEntryPoint()
                .environmentObject(appData)
        }
    }
}
