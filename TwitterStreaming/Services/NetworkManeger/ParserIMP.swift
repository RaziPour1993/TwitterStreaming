import Foundation



class ParserIMP: Parser  {
    
    func parse<T: Decodable>(data: Data?) -> T? {
        
        guard let data = data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
}
