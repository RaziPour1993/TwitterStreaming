import Foundation

protocol LiveTweetsService {
    func startStream(with filter: StreamFilter, completion: @escaping (Result<Tweet, NetworkResponseStatus>) -> Void)
}

class LiveTweetsServiceNetworkIMP: LiveTweetsService {
    
    var networkManeger: NetworkManeger
    var parser: Parser
    let queue = DispatchQueue.global(qos: .userInitiated)
    
    init() {
        self.networkManeger = StreamManagerRequestIMP(dispatchQueue: queue)
        self.parser = ParserIMP()
    }
    
    func startStream(with filter: StreamFilter, completion: @escaping (Result<Tweet, NetworkResponseStatus>) -> Void) {
        networkManeger.disconnect()
        networkManeger.request(with: NetworkRequestIMP.stream(filter)) { result in
            switch result {
            case .success(let data):
                debugPrint(String(data: data!, encoding: String.Encoding.utf8)!)
                guard let tweet: Tweet = self.parser.parse(data: data) else {
                    completion(.failure(.internalStatus(status: .noData, message: "")))
                    return
                }
                completion(.success(tweet))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

