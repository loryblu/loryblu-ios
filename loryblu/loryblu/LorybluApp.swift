import SwiftUI

@main
struct LorybluApp: App {

    var body: some Scene {
        WindowGroup {
          ContentView()
                .onOpenURL { url in
                    let router = url.absoluteString
                    print(router.URLDecoder)
                }
        }
    }
}
