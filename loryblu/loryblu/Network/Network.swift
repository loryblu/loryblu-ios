import Foundation

class Network {
    // MARK: - Property(ies).
    private let session: URLSession

    static private var instance: Network?

    // MARK: - Initialization.
    init() {
        session = URLSession.shared
    }

    // MARK: - Method(s).
    func requestData(using request: Request) async throws -> Data? {

        guard let url = URL(string: request.baseURL + request.path) else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        let header: [String: String] = [
            "Accept": "*/*",
            "User-Agent": "Loryblu-iOS",
            "Content-Type": "application/json"
        ]

        for (key, value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        for (key, value) in request.header ?? [:] {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        let (data, response) =  try await session.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: "Response fail", code: 499, userInfo: nil)
        }

        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw NSError(domain: "Unexpected fail", code: response.statusCode, userInfo: ["error": data])
        }

        return data
    }

    func request<T: Decodable>(request: Request, returning type: T.Type) async throws -> T {
        guard let data = try await requestData(using: request) else {
            throw NetworkError.parseError
        }

        do {
            guard let object = JSONParser.parseObject(type, from: data) else {
                throw NetworkError.parseError
            }
            return object
        } catch {
            throw NetworkError.parseError
        }
    }
}
