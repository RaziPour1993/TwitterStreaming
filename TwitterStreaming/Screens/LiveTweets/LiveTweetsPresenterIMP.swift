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
    
    var tweetsViewModel: TweetsViewModel! {
        didSet {
            self.view?.updated(tweets: self.tweetsViewModel)
        }
    }
    
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
        let items = [Tweet(), Tweet(), Tweet(), Tweet()]
//        self.tweetsViewModel = TweetsViewModel(items, delegate: self)
        
        self.service.retrieveRules { result in
            debugPrint(result)
        }
    }
    
    func set(view: LiveTweetsPresentingView) {
        self.view = view
    }
    
}

extension LiveTweetsPresenterIMP: TweetsViewModelDelegate {
    func didSelect(tweet: Tweet) {
        self.delegate?.didSelect(tweet: tweet)
    }
    
}
