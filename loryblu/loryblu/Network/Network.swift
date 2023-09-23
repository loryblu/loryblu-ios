//
//  Network.swift
//  suelencristina-fintech
//
//  Created by Suh on 03/07/23.
//

import UIKit

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
    func requestData(
            using request: Request,
            onComplete: @escaping (Result<Data, Error>) -> Void
        ) {

            guard let url = URL(string: request.baseURL + request.path) else {
                onComplete(.failure(NetworkError.invalidURL))
                return
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue

            if request.method == .post {
                do {
                    let credentialsData = try JSONSerialization.data(
                        withJSONObject: request.body as Any, options: .prettyPrinted)
                    urlRequest.httpBody = credentialsData
                } catch {
                    onComplete(.failure(NetworkError.authenticationError))
                }
            }

            let header: [String: String] = [
                "Accept": "*/*",
                "User-Agent": "Thunder Client (https://www.thunderclient.com)",
                "Content-Type": "application/json"
            ]

            for (key, value) in header {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }

            let datatask = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    onComplete(.failure(NetworkError.requestFailed))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    _ = NSError(domain: "Response fail", code: 499, userInfo: nil)
                    onComplete(.failure(NetworkError.notFound))
                    return
                }

                guard response.statusCode >= 200 && response.statusCode < 300 else {
                    _ = NSError(domain: "Unexpected fail", code: response.statusCode, userInfo: nil)
                    onComplete(.failure(NetworkError.notFound))
                    return
                }

                guard let data = data else {
                    _ = NSError(domain: "No Data", code: 499, userInfo: nil)
                    onComplete(.failure(NetworkError.invalidURL))
                    return
                }

                onComplete(.success(data))

            }
            datatask.resume()
        }

        func request<T: Decodable>(
            request: Request,
            returning type: T.Type,
            onComplete: @escaping (Result<T?, Error>) -> Void
        ) {
            requestData(using: request) { result in
                switch result {
                case .failure:
                    onComplete(.failure(NetworkError.requestFailed))
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let object = try decoder.decode(type, from: data)
                        onComplete(.success(object))
                    } catch {
                        onComplete(.failure(NetworkError.parseError))
                    }
                }
            }
        }
}
