import Factory
import Foundation

class RegisterRepository {

    let network: Network

    init(network: Network) {
        self.network = network
    }

    func register(user: UserRegister) async throws -> ResponseMessage {
        let request = RequestModel.Builder()
            .with(baseURL: "https://loryblu-homologation.onrender.com/")
            .with(path: "auth/register")
            .with(method: .post)
            .with(body: user)
            .with(addHeaderName: "Accept", value: "*/*")
            .with(addHeaderName: "User-Agent", value: "LoryBlu(iOS)")
            .with(addHeaderName: "Content-Type", value: "application/json")
            .build()

        let response = try await network.request(request: request, returning: ResponseMessage.self)

        return response
    }
}
