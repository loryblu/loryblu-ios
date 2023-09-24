import SwiftUI

@main
struct LorybluApp: App {

    var body: some Scene {
        WindowGroup {
//           ContentView()
            ResetPasswordScreen(fecthEmail: ResetPasswordScreen.FechtEmail.idle).environmentObject(ResetPasswordModel())
             // fazer animação e navegacao para login.
        }
    }
}
