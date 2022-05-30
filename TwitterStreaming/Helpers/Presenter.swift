import Foundation
import UIKit

protocol PresentingView: AnyObject {
    func willLoadingData()
    func didLoadingData()
    func warning(message: String)
}

protocol Presenter: AnyObject {
    func present()
}

protocol ScreenDelegate: AnyObject {
    
}

extension PresentingView where Self: UIViewController {
    
    func willLoadingData() {
        
    }
    
    func didLoadingData() {
        
    }
    
    func warning(message: String) {
        debugPrint("Warning : ", message)
    }
    
}
