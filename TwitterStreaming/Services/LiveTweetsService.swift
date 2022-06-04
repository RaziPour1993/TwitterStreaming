import Foundation

protocol LiveTweetsService {
    func startStream(with filter: StreamFilter, completion: @escaping (Result<Tweet, NetworkResponseStatus>) -> Void)
    func stopStream(completion: @escaping (Bool) -> Void)
}

class LiveTweetsServiceNetworkIMP: LiveTweetsService {
    
    var networkManeger: NetworkManeger?
    var parser: Parser
    let queue = DispatchQueue.global(qos: .userInitiated)
    
    init() {
        self.networkManeger = StreamManagerRequestIMP(dispatchQueue: queue)
        self.parser = ParserIMP()
    }
    
    func startStream(with filter: StreamFilter, completion: @escaping (Result<Tweet, NetworkResponseStatus>) -> Void) {
        networkManeger!.request(with: NetworkRequestIMP.stream(filter)) { result in
            switch result {
            case .success(let data):
                debugPrint(String(data: data!, encoding: String.Encoding.utf8)!)
                guard let tweet: Tweet = self.parser.parse(data: data) else { return }
                completion(.success(tweet))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func stopStream(completion: @escaping (Bool) -> Void) {
        self.networkManeger!.disconnect { result in
            self.networkManeger = nil
            self.networkManeger = StreamManagerRequestIMP(dispatchQueue: self.queue)
            completion(true)
        }
    }
    
}
