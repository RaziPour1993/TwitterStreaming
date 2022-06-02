import Foundation

protocol NetworkManeger {
    func request(with request: NetworkRequest, completion: @escaping (Result<Data?, NetworkResponseStatus>)-> Void)
}

class NetworkManegerIMP: NetworkManeger {
    
    static let shared = NetworkManegerIMP()
    let session: URLSession
    var networkResponseStatusManeger: NetworkResponseStatusManeger
    
    init() {
        self.networkResponseStatusManeger = NetworkResponseStatusManegerIMP()
        self.session = URLSession.shared
    }
    
    func request(with request: NetworkRequest, completion: @escaping (Result<Data?, NetworkResponseStatus>) -> Void) {
        debugPrint(request)
        
        guard let request = request.request else {
            completion(.failure(.internalStatus(status: .invalidUrl, message: "InvalidURL")))
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                let responseStatus = self.networkResponseStatusManeger.handel(data, response, error)
                
                if responseStatus.isSuccess {
                    completion(.success(data))
                } else {
                    completion(.failure(responseStatus))
                }
            }
            
        }
        
        task.resume()
    }
    
}

protocol NetworkResponseStatusManeger {
    func handel(_ data: Data?, _ response: URLResponse?, _ error: Error?)-> NetworkResponseStatus
}

class NetworkResponseStatusManegerIMP: NetworkResponseStatusManeger {
    func handel(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> NetworkResponseStatus {
        let response = response as? HTTPURLResponse
        let message = response?.statusCode.description
        let status = NetworkResponseStatus(statusCode: response?.statusCode, message: message)
        return status
    }
}
