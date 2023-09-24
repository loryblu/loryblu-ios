import Foundation

extension String {
    var URLDecoder: String {
        return String(NSString(string: self).removingPercentEncoding ?? "")
    }
}
