import SwiftUI

@main
struct LorybluApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            RegisterChildView(viewModel: RegisterChildViewModel(user: Register()))
            // fazer animação e navegacao para login.
        }
    }
}
