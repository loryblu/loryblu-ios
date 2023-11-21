import SwiftUI

struct AppEntryPoint: View {
    @EnvironmentObject var appData: AppData

    var body: some View {
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
}
