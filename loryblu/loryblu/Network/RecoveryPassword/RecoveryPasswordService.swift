import Foundation
import SwiftUI

class RecoveryPasswordService {

    static let recoveryURl = Server.recoveryPasswordURL
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let sessionURL = URLSession(configuration: configuration)

    func recoveryPassword(with email: String, onComplete: @escaping(Response?) -> Void) {
        guard let url = URL(string: RecoveryPasswordService.recoveryURl) else {
            onComplete(nil)
            return
        }

        let httMethod: String = "POST"
        var request = URLRequest(url: url)
        request.httpMethod = httMethod

        let bodyRequest: [String: Any?] = ["email": "\(email)"]
        let json = try? JSONSerialization.data(withJSONObject: bodyRequest)

        request.httpBody = json

        let dataTask = RecoveryPasswordService.sessionURL.dataTask(with: request) { data, reponse, error in
            if error == nil {

                if let reponse = reponse as? HTTPURLResponse, reponse.statusCode  == 200, let data = data {
                    onComplete(nil)
                     print("response ok")

                    do {
                        let message = try JSONDecoder().decode(Response.self, from: data)
                        onComplete(message)
                        print(message)
                    } catch {
                        print(error, "response error")
                        onComplete(nil)
                    }
                    onComplete(nil)
                    return
                }

            } else {
                onComplete(nil)
                print(error as Any)
            }

        }
        dataTask.resume()
    }
}
