import SwiftUI

@main
struct LorybluApp: App {
    @StateObject private var appData: AppData = .init()
    var body: some Scene {
        WindowGroup {
            PuzzleView(onCancel: {}, props: .init(isAvaliable: true))
//            AppEntryPoint()
//                .environmentObject(appData)
        }
    }
}
