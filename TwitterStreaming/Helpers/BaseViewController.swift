//
//  BaseViewController.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import UIKit

class BaseViewController: UIViewController, PresentingView {
    
    deinit {
        debugPrint("📤 deinit \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
