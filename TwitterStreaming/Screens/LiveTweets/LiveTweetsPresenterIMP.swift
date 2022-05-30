//
//  LiveTweetsPresenterIMP.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

class LiveTweetsPresenterIMP {
    
    weak var view: LiveTweetsPresentingView?
    weak var delegate: LiveTweetsScreenDelegate?
    var service: LiveTweetsService
    
    init(_ service: LiveTweetsService, _ delegate: LiveTweetsScreenDelegate?) {
        self.delegate = delegate
        self.service = service
    }
    
    deinit {
        debugPrint("📤 deinit \(self)")
    }
    
}

extension LiveTweetsPresenterIMP: LiveTweetsPresenter {
    
    func present() {

    }
    
    func set(view: LiveTweetsPresentingView) {
        self.view = view
    }
    
}
