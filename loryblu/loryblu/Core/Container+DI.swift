import Factory
import Foundation

extension Container {
    var appData: Factory<AppData> {
        self {
            AppData()
        }.singleton
    }
}
