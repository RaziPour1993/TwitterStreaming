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


enum URLs {
    case server
    
    var link: String {
        switch self {
        case .server: return "https://api.twitter.com/2/tweets/search/stream"
        }
    }
}

enum NetworkRequestIMP {
    case addRules(_ info: AddRules)
    case deleteRules(_ info: DeleteRules)
    case retrieveRules
    case stream(_ filter: StreamFilter)
}

let token = "AAAAAAAAAAAAAAAAAAAAAK%2BeUgEAAAAAcBPofcvampMachJq8uDh%2F2DrXsA%3DSOlOZ1jP9FAeqCvoqx6Mqc9B87r0OgjZPpOsYJexFzJpUQEfLw"

extension NetworkRequestIMP: NetworkRequest {
    
    private var enviroment: String {
        return URLs.server.link
    }
    
    
    var pathURL: URL? {
        var url = ""
        
        switch self {
        case .addRules : url = "/rules"
        case .deleteRules: url = "/rules"
        case .retrieveRules: url = "/rules"
        case .stream(let filter):
            url = "?expansions=author_id&tweet.fields=created_at,text,entities,public_metrics,source&user.fields=name,username,verified,profile_image_url,location,url,public_metrics&media.fields=type,url,public_metrics&place.fields=full_name,country"
        }
        
        
        
//        url = "?tweet.fields=created_at,text,public_metrics,source&user.fields=name,username,profile_image_url,url,public_metrics&media.fields=public_metrics"
        
        guard let strURL = (self.enviroment + url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let urlValid = URL(string: strURL) else {
            return nil
        }
        
        print(urlValid)
        return urlValid
        
    }
    
    var method: HTTPMethod {
        switch  self {
        case .retrieveRules, .stream:
            return .get
        case .addRules, .deleteRules:
            return .post
        }
    }
    
    var body: HTTPBody? {
        
        var data: Data?
        
        switch self {
        case .addRules(let info):
            data = self.bodyEncoding?.encode(parameters: info)
        case .deleteRules(let info):
            data = self.bodyEncoding?.encode(parameters: info)
//        case .stream(let info) :
//            data = self.bodyEncoding?.encode(parameters: info)
        default: data = nil
        }
        
        return data
    }
    
    var bodyEncoding: HTTPBodyEncoding? {
        switch self {
        case .addRules, .deleteRules:
            return JSONEncoding()
//        case .stream:
//            return URLEncoding()
        default: return nil
        }
    }
    
    var headers: HTTPHeaders? {
        var headers = HTTPHeaders()
        headers["Authorization"] = "Bearer \(token)"
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    var request: URLRequest? {
        guard let url = self.pathURL else { return nil }
        var request = URLRequest(url: url)
        request.httpBody = self.body
        request.headers = self.headers
        request.httpMethod = self.method.rawValue
        
        return request
    }
    
}

extension URLRequest {
    var headers: HTTPHeaders? {
        set {
            newValue?.forEach { (String, value) in
                self.setValue(value, forHTTPHeaderField: String)
            }
        }
        
        get {
            return self.allHTTPHeaderFields
        }
    }
}

