import Foundation

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
        }
        
        guard let strURL = (self.enviroment + url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let urlValid = URL(string: strURL) else {
            return nil
        }
        
        print(urlValid)
        return urlValid
        
    }
    
    var method: HTTPMethod {
        switch  self {
        case .retrieveRules:
            return .get
        case .deleteRules:
            return .post
        case .addRules:
            return .post
        }
    }
    
    var body: HTTPBody? {
        
        var data: Data?
        
        switch self {
        case .addRules(let info): data = self.bodyEncoding?.encode(parameters: info)
        case .deleteRules(let info): data = self.bodyEncoding?.encode(parameters: info)
        default: data = nil
        }
        
        return data
    }
    
    var bodyEncoding: HTTPBodyEncoding? {
        switch self {
        case .addRules, .deleteRules:
            return JSONEncoding()
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

