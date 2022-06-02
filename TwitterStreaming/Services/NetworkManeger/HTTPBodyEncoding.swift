import Foundation

protocol HTTPBodyEncoding {
    func encode<T: Encodable>(parameters: T) -> Data?
}

struct URLEncoding: HTTPBodyEncoding {
    
    func encode<T>(parameters: T) -> Data? where T : Encodable {
        let dictionary = parameters.dictionary ?? [:]
        let array = dictionary.compactMap { (key, value) -> String in return "\(key)=\(value)" }
        let string = array.joined(separator: "&")
        return string.data(using: .utf8)
    }
    
}

struct JSONEncoding: HTTPBodyEncoding {
    
    func encode<T>(parameters: T) -> Data? where T : Encodable {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(parameters)
        debugPrint(String(data: data ?? Data(), encoding: .utf8)!)
        return data
    }
    
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
