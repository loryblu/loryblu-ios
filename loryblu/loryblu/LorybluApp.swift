import SwiftUI

@main
struct LorybluApp: App {
    var register = Register()
    var body: some Scene {
        WindowGroup {
            RegisterChildView(viewModel: RegisterChildViewModel(user: register))
                .preferredColorScheme(.light)
             // fazer animação e navegacao para login.
        }
    }
}
