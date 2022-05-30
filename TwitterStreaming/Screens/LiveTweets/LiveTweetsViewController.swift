//
//  LiveTweetsViewController.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import UIKit

class LiveTweetsViewController: BaseViewController {

    var presenter: LiveTweetsPresenter!
    
    init(_ presenter: LiveTweetsPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter.set(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.viewConfig()
        self.presenter.present()
    }
    
}

extension LiveTweetsViewController {
    
    func config() {
        
    }
    
    func viewConfig() {
        self.navigationItem.title = "Live Tweets".localized
    }
    
    
}

extension LiveTweetsViewController: LiveTweetsPresentingView {
    
}
