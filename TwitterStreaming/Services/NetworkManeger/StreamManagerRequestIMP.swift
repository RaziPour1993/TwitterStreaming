import Foundation

class StreamManagerRequestIMP: NSObject, NetworkManeger {
    
    private lazy var session: URLSession = {
        let operationQueue = OperationQueue()
        operationQueue.underlyingQueue = self.dispatchQueue
        return URLSession(configuration: .default,
                          delegate: self,
                          delegateQueue: operationQueue)
    }()
    
    private var currentTask: URLSessionDataTask?
    private var streamCompletion: ((Result<Data?, NetworkResponseStatus>) -> Void?)?
    private var disconnectCompletion: ((Bool) -> Void?)?
    
    var statusManeger: NetworkResponseStatusManeger
    unowned(unsafe) let dispatchQueue: DispatchQueue
    
    init(dispatchQueue: DispatchQueue) {
        self.dispatchQueue = dispatchQueue
        self.statusManeger = StreamManagerStatusManegerIMP()
        super.init()
    }
    
    func request(with request: NetworkRequest, completion: @escaping (Result<Data?, NetworkResponseStatus>) -> Void) {
        guard let request = request.request else {
            completion(.failure(.internalStatus(status: .invalidUrl, message: "InvalidURL")))
            return
        }
        
        self.streamCompletion = completion

        currentTask = session.dataTask(with: request)
        currentTask?.resume()
    }
    
    func disconnect() {
        currentTask?.cancel()
        currentTask = nil
    }
    
    func disconnect(completion: @escaping (Bool) -> Void) {
        self.streamCompletion = nil
        self.disconnectCompletion = completion
        if currentTask == nil {
            self.disconnectCompletion?(true)
            self.disconnectCompletion = nil
            return
        }
        self.disconnect()
    }
}

extension StreamManagerRequestIMP: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let sameHost = task.originalRequest?.url?.host == challenge.protectionSpace.host
        let isAuthMethod = challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
        
        guard let serverTrust = challenge.protectionSpace.serverTrust,
              sameHost && isAuthMethod else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        debugPrint(String(data: data, encoding: String.Encoding.utf8)!)
        guard dataTask.state == .running else { return }
        DispatchQueue.main.async {
            self.streamCompletion?(.success(data))
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        debugPrint(error ?? "")
        DispatchQueue.main.async {
            let responseStatus = self.statusManeger.handel(nil, nil, error)
            self.streamCompletion?(.failure(responseStatus))
            self.disconnectCompletion?(true)
            self.streamCompletion = nil
            self.disconnectCompletion = nil
        }
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        session.finishTasksAndInvalidate()
    }
}

class StreamManagerStatusManegerIMP: NetworkResponseStatusManeger {
    func handel(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> NetworkResponseStatus {
        let errorCode = error?.code
        let message = error?.description
        let status = NetworkResponseStatus(statusCode: errorCode, message: message)
        return status
    }
}
