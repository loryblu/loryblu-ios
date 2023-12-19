import Factory
import SwiftUI

struct AppEntryPoint: View {
    @ObservedObject var appData: AppData = Container.shared.appData()

    var body: some View {
        switch appData.loginStatus {
        case .loading:
            Text("Loading")
        case .logged:
            homeNavitationStack
        case .notLogged:
            loginNavitationStack
        }
    }
    
    private var loginNavitationStack: some View {
        LoginNavigationStack()
            .environmentObject(appData)
            .sheet(isPresented: $appData.isTokenReceived) {
                NewPasswordScreen.build()
                    .environmentObject(appData)
            }
            .onOpenURL { url in
                let deepLinkHandler = DeepLinkHandler()
                deepLinkHandler.handleDeepLink(with: url, appData: appData)
            }
    }

    private var homeNavitationStack: some View {
        HomeNavigationStack()
            .environmentObject(appData)
    }
}
