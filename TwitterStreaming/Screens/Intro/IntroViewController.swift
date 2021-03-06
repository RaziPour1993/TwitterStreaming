//
//  IntroViewController.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import UIKit

class IntroViewController: BaseViewController {
    
    var presenter: IntroPresenter!
    
    init(_ presenter: IntroPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter.set(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.present()
    }
    
}


extension IntroViewController: IntroPresentingView {
    
    
}
