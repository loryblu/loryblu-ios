import Foundation

enum JSONParser {

    ///
    /// Convert a Dictionary to Data containing a JSON
    /// - Parameters:
    ///     - from: A `Dictionary` typed `[String: Any]` to be converted into a JSON
    /// - Returns: A `Data` type with `encoded JSON`
    ///
    static func parseData(from dictionary: [String: Any]) -> Data? {
        guard let result = try? JSONSerialization.data(withJSONObject: dictionary) else {
            return nil
        }

        return result
    }

    ///
    /// Converts Encodable entity to Data containing a JSON
    /// - Parameters:
    ///     - from: An  `Encodable`type entity
    /// - Returns: A `Data` type with `encoded JSON`
    ///
    static func parseData(from encodable: Encodable) -> Data? {
        guard let result = try? JSONEncoder().encode(encodable) else {
            return nil
        }
        return result
    }

    ///
    /// Converts Encodable entity to String representing a JSON
    /// - Parameters:
    ///     - from: An  `Encodable`type entity
    /// - Returns: A `String` containing the `encoded JSON`
    ///
    static func parseJSONString(from encodable: Encodable) -> String? {
        guard let data = parseData(from: encodable), let result = String(data: data, encoding: .utf8) else {
            return nil
        }
        return result
    }

    ///
    /// Convert a Dictionary to String representing a JSON
    /// - Parameters:
    ///     - from: A `Dictionary` typed `[String: Any]` to be converted into a JSON
    /// - Returns: A `String` containing the `encoded JSON`
    ///
    static func parseJSONString(from dictionary: [String: Any]) -> String? {
        guard let data = parseData(from: dictionary), let result = String(data: data, encoding: .utf8) else {
            return nil
        }
        return result
    }

    ///
    /// Converts a Data containing a JSON into Entity
    /// - Parameters:
    ///     - type: The type of Entity to be returned
    ///     - from: The `Data` to be converted to an Entity
    /// - Returns: The object defined by type parameter
    ///
    static func parseObject<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        guard let result = try? JSONDecoder().decode(type, from: data) else {
            return nil
        }
        return result
    }

    ///
    /// Converts a String containing a JSON into Entity
    /// - Parameters:
    ///     - type: The type of Entity to be returned
    ///     - from: The `String` to be converted to an Entity
    /// - Returns: The object defined by type parameter
    ///
    static func parseObject<T: Decodable>(_ type: T.Type, from jsonString: String) -> T? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        return parseObject(type, from: jsonData)
    }
}
