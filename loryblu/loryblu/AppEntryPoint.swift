import SwiftUI

struct AppEntryPoint: View {
    @EnvironmentObject var appData: AppData

    var body: some View {
        NavigationStack {
            LoginView()
                .environmentObject(appData)
                .navigationDestination(isPresented: $appData.isTokenReceived) {
                    NewPasswordScreen(model: NewPasswordModel(), appData: appData)
                }
        }
        .onOpenURL { url in
            let deepLinkHandler = DeepLinkHandler()
            deepLinkHandler.handleDeepLink(with: url, appData: appData)
        }
    }
}
