import Factory
import Foundation

class AuthenticationRepository {
    let network: Network

    init(network: Network) {
        self.network = network
    }

    func login(email: String, password: String) async throws -> UserAuth {
        let auth = Authentication(email: email, password: password)

        let request = RequestModel.Builder()
            .with(baseURL: Server.baseURL)
            .with(path: Endpoint.login)
            .with(method: .post)
            .with(body: JSONParser.parseData(from: auth))
            .with(addHeaderName: "Accept", value: "*/*")
            .with(addHeaderName: "User-Agent", value: "LoryBlu(iOS)")
            .with(addHeaderName: "Content-Type", value: "application/json")
            .build()

        let response = try await network.request(request: request, returning: UserAuth.self)

        return response
    }
}


