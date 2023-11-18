import SwiftUI

class LoginNavigationCoordinator: ObservableObject {
    
    enum Destination: Hashable {
        case resetPassword
        case responsibleRegister
    }
    
    @Published var path: [Destination]
    
    init() {
        path = []
    }
    
    private func navigate(to destination: Destination) {
        self.path.append(destination)
    }
    
    func openResetPassword() {
        navigate(to: .resetPassword)
    }
    
    func openRegister() {
        navigate(to: .responsibleRegister)
    }
    
    func destinationView(to destination: Destination) -> some View {
        Group {
            switch destination {
            case .resetPassword:
                ResetPasswordScreen.build()
                    .environmentObject(self)
            case .responsibleRegister:
                EmptyView()
                    .environmentObject(self)
            }
        }
    }
    
}
