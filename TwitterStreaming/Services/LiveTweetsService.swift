import Foundation

protocol LiveTweetsService {
    func addRules(info: AddRules, completion: @escaping(Result<Bool, NetworkResponseStatus>)-> Void)
    func deleteRules(info: DeleteRules, completion: @escaping(Result<Bool, NetworkResponseStatus>)-> Void)
    func retrieveRules(completion: @escaping(Result<Rules, NetworkResponseStatus>)-> Void)
}


class LiveTweetsServiceIMP: LiveTweetsService {
    
    var networkManeger: NetworkManeger
    var parser: Parser
    
    init() {
        self.networkManeger = NetworkManegerIMP()
        self.parser = ParserIMP()
    }
    
    
    func addRules(info: AddRules, completion: @escaping (Result<Bool, NetworkResponseStatus>) -> Void) {
        self.networkManeger.request(with: NetworkRequestIMP.addRules(info)) { (result) in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteRules(info: DeleteRules, completion: @escaping (Result<Bool, NetworkResponseStatus>) -> Void) {
        self.networkManeger.request(with: NetworkRequestIMP.deleteRules(info)) { (result) in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func retrieveRules(completion: @escaping (Result<Rules, NetworkResponseStatus>) -> Void) {
        self.networkManeger.request(with: NetworkRequestIMP.retrieveRules) { (result) in
            switch result {
            case .success(let data):
                let retrieveRules: RetrieveRules = self.parser.parse(data: data) ?? RetrieveRules()
                completion(.success(retrieveRules.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
