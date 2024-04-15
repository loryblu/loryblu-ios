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
            Network()
        }
    }

    var autenticationRepository: Factory<AuthenticationRepository> {
        Factory(self) {
            AuthenticationRepository(network: self.network())
        }
    }

    var setPasswordRepository: Factory<RepositorySetPassword> {
        Factory(self) {
            RepositorySetPassword(network: self.network())
        }
    }

    var registerRepository: Factory<RegisterRepository> {
        Factory(self) {
            RegisterRepository(network: self.network())
        }
    }

    var taskRepository: Factory<TaskRepository> {
        Factory(self) {
            TaskRepository(network: self.network())
        }
    }
}
