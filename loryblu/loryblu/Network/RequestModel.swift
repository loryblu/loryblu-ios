import Foundation

struct RequestModel: Request {
    var baseURL: String
    var path: String
    var method: RequestMethod
    var header: [String: String]?
    var body: Data?
}

extension RequestModel {

    ///
    /// A helper class to help build new requests
    ///
    class Builder {
        private var model = RequestModel(baseURL: "", path: "", method: .get, header: [:], body: nil)

        init() {}

        func with(baseURL: String) -> Self {
            model.baseURL = baseURL
            return self
        }

        func with(path: String) -> Self {
            model.path = path
            return self
        }

        func with(method: RequestMethod) -> Self {
            model.method = method
            return self
        }

        func with(addHeaderName headerName: String, value: String) -> Self {
            model.header?[headerName] = value
            return self
        }

        func with(headers: [String: String]) -> Self {
            headers.forEach {
                _ = self.with(addHeaderName: $0.key, value: $0.value)
            }
            return self
        }

        func with(body data: Data?) -> Self {
            model.body = data
            return self
        }

        func with(body encodable: Encodable) -> Self {
            return self.with(body: JSONParser.parseData(from: encodable))
        }

        func with(body dictionary: [String: Any]) -> Self {
            return self.with(body: JSONParser.parseData(from: dictionary))
        }

        ///
        /// Builds a new RequesModel with all set parameters
        ///
        /// - Returns: A RequestModel entity containing all set properties
        func build() -> RequestModel {
            return model
        }
    }
}
