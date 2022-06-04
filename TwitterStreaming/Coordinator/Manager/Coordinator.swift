import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var screenFactory: ScreenFactory  { get }
    var coordinatorFactory: CoordinatorFactory { get }
    var router: Router { get }
    
    func start()
    
}

protocol CoordinatorDelegate: AnyObject {
    
}
