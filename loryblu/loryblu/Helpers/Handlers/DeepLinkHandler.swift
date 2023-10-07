import Foundation
import SwiftUI
class DeepLinkHandler {

    func handleDeepLink(with url: URL, appData: AppData) {
        if url.scheme == "loryblu" {
            let loryURl = URLComponents(string: (url.absoluteString).URLDecoder)
            let token = getToken(url: loryURl?.queryItems)
            appData.isTokenReceived = true
            appData.token = token
        }
     }

    func getToken(url: [URLQueryItem]?) -> String {
        var recoveryToken: String = ""
        guard let key = url else {  return recoveryToken  }

        guard let token = key[0].value else { return recoveryToken  }

        recoveryToken = token
        return recoveryToken
    }

}
