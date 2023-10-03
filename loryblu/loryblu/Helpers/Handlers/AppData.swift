import Foundation

class AppData: ObservableObject {
    @Published var isTokenReceived: Bool = false
    @Published var token: String = ""
}
