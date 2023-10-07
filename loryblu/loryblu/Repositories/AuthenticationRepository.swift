import Foundation

class AuthenticationRepository {

    let network: Network

    init(network: Network = Network.shared) {
        self.network = network
    }

    func login(email: String, password: String) async throws -> ResponseMessage {
        let auth = Authentication(email: email, password: password)

        let request = RequestModel.Builder()
            .with(baseURL: "https://loryblu-homologation.onrender.com/")
            .with(path: Endpoint.login)
            .with(method: .post)
            .with(body: JSONParser.parseData(from: auth))
            .with(addHeaderName: "Accept", value: "*/*")
            .with(addHeaderName: "User-Agent", value: "LoryBlu(iOS)")
            .with(addHeaderName: "Content-Type", value: "application/json")
            .build()

        let response = try await network.request(request: request, returning: ResponseMessage.self)

        return response
    }
}
