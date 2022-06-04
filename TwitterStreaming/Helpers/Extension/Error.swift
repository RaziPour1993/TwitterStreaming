import Foundation

extension Error {
    var code: Int { return (self as NSError).code }
    var description: String { return (self as NSError).userInfo["NSLocalizedDescription"] as? String ?? "" }
}
