//
//  Network.swift
//  suelencristina-fintech
//
//  Created by Suh on 03/07/23.
//

import Foundation

class Network {
    // MARK: - Property(ies).
    private let session: URLSession
    static var shared: Network {
        if let instance = instance {
            return instance
        }

        let network = Network()
        instance = network
        return network
    }

    static private var instance: Network?

    // MARK: - Initialization.
    private init() {
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
        
//        if request.method == .post || request.method == .put {
//            do {
//                let credentialsData = try JSONSerialization.data(
//                    withJSONObject: request.body as Any, options: .prettyPrinted)
//                urlRequest.httpBody = credentialsData
//            } catch {
//                throw NetworkError.authenticationError
//            }
//        }



        let header: [String: String] = [
            "Accept": "*/*",
            "User-Agent": "Thunder Client (https://www.thunderclient.com)",
            "Content-Type": "application/json"
        ]

        for (key, value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        let resultData = try await withCheckedThrowingContinuation { continuation in
            let datatask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    continuation.resume(with: .success(data))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    _ = NSError(domain: "Response fail", code: 499, userInfo: nil)
                    continuation.resume(with: .failure(NetworkError.notFound))
                    return
                }

                guard response.statusCode >= 200 && response.statusCode < 300 else {
                    _ = NSError(domain: "Unexpected fail", code: response.statusCode, userInfo: nil)
                    continuation.resume(with: .failure(NetworkError.notFound))
                    return
                }

                guard let data = data else {
                    _ = NSError(domain: "No Data", code: 499, userInfo: nil)
                    continuation.resume(with: .failure(NetworkError.invalidURL))
                    return
                }

                continuation.resume(with: .success(data))
            }
            datatask.resume()
        }

        return resultData
    }

    func request<T: Decodable>(request: Request, returning type: T.Type) async throws -> T {
        guard let data = try await requestData(using: request) else {
            throw NetworkError.parseError
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw NetworkError.parseError
        }
    }
}
