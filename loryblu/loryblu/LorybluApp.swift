import SwiftUI

@main
struct LorybluApp: App {
//    @StateObject private var appData: AppData = .init()
    var body: some Scene {
        WindowGroup {
            FrequencyRotine(sunday: true,
                            monday: false,
                            tuesday: true,
                            wednesday: false,
                            thurday: true,
                            friday: false,
                            satuday: true, title: .constant(LBStrings.Locbook.titleStudy
        ))
//            AppEntryPoint()
//                .environmentObject(appData)
//                .onOpenURL { url in
//                    let deepLinkHandler = DeepLinkHandler()
//                    deepLinkHandler.handleDeepLink(with: url, appData: appData)
//                }
        }
    }
}
