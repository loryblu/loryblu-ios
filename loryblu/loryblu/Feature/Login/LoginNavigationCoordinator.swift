import SwiftUI

@MainActor
class LoginNavigationCoordinator: ObservableObject {
    
    @EnvironmentObject var appData: AppData
    
    enum Destination {
        enum Navigation: String, Identifiable  {
            case resetPassword
            case responsibleRegister
            case setNewPassword
            
            var id: String {
                self.rawValue
            }
        }
        
        enum FullScreenPage: String, Identifiable {
            case login
            
            var id: String {
                self.rawValue
            }
        }
    }
    
    // MARK: - Internal Properties
    
    @Published var path: [Destination.Navigation]
    @Published var fullScreen: Destination.FullScreenPage?
    
    // MARK: - Initializers
    
    init() {
        path = []
        fullScreen = nil
    }
        
    // MARK: - Internal Methods
    
    func showResetPassword() {
        navigate(to: .resetPassword)
    }
    
    func showRegister() {
        navigate(to: .responsibleRegister)
    }
    
    func showSetNewPassword() {
        navigate(to: .setNewPassword)
    }
    
    func backToHome() {
        path.removeAll()
    }
    
    @ViewBuilder
    func buildView(page destination: Destination.Navigation) -> some View {
        switch destination {
        case .resetPassword:
            ResetPasswordScreen.build()
                .environmentObject(self)
        case .responsibleRegister:
            RegisterResponsibleView.build()
                .environmentObject(self)
        case .setNewPassword:
            NewPasswordScreen.build()
                .environmentObject(self)
                .environmentObject(appData)
        }
    }
    
    @ViewBuilder
    func buildView(cover destination: Destination.FullScreenPage) -> some View {
        switch destination {
        case .login:
            LoginView.build()
                .environmentObject(self)
        }
    }

    // MARK: - Private Methods

    private func navigate(to destination: Destination.Navigation) {
        self.path.append(destination)
    }

}
