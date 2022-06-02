import Foundation

protocol NetworkRequest {
    var pathURL: URL? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var body: HTTPBody? { get }
    var bodyEncoding: HTTPBodyEncoding? { get }
    var request: URLRequest? { get }
}

enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

typealias HTTPBody = Data
typealias HTTPHeaders = [String : String]
