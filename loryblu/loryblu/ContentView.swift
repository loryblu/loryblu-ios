import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData: AppData
    var body: some View {
        if appData.isTokenReceived {
            NewPasswordScreen(model: NewPasswordModel(), appData: appData)
        } else {
            VStack {
                LBIcon.logoFull.image
                Text(LBStrings.General.hello)
                    .font(LBFont.head2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var appData: AppData = .init()
        ContentView()
            .environmentObject(appData)
    }
}
