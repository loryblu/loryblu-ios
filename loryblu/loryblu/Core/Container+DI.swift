import Factory
import Foundation

extension Container {
    var appData: Factory<AppData> {
        self {
            AppData()
        }.singleton
    }
    
    var network: Factory<Network> {
        self {
            Network.shared
        }
    }
    
    var autenticationRepository: Factory<AuthenticationRepository> {
        self {
            AuthenticationRepository(network: self.network())
        }
    }
}
