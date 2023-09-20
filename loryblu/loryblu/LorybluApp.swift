import SwiftUI

@main
struct LorybluApp: App {
//    var user =  RegisterChildViewModel(user: .fixture())
    var body: some Scene {
        WindowGroup {
//            RegisterChildView(viewModel: user)
            RegisterResponsibleView()
            // fazer animação e navegacao para login.
        }
    }
}
