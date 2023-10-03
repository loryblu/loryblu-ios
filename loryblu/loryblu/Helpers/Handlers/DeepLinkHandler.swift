import Foundation
import SwiftUI
class DeepLinkHandler {

    @Published var setPassword: SetPassword = SetPassword(password: "", recoveryToken: "")

    func handleDeepLink(with url: URL, appData: AppData) {
        if url.scheme = 
        let loryURl = URLComponents(string: (url.absoluteString).URLDecoder)
        let token = getToken(url: loryURl?.queryItems)
        setPassword.recoveryToken = token
        return
    }

    func getToken(url: [URLQueryItem]?) -> String {
        var recoveryToken: String = ""
        guard let key = url else {  return recoveryToken  }

        guard let token = key[0].value else { return recoveryToken  }

        recoveryToken = token
        return recoveryToken
    }

}
