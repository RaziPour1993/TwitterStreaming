//
//  TweetDetailPresenterIMP.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

class TweetDetailPresenterIMP {
    
    weak var view: TweetDetailPresentingView?
    weak var delegate: TweetDetailScreenDelegate?
    var tweet: Tweet
    
    init(_ tweet: Tweet, _ delegate: TweetDetailScreenDelegate) {
        self.tweet = tweet
        self.delegate = delegate
    }
    
    deinit {
        debugPrint("📤 deinit \(self)")
    }
    
}

extension TweetDetailPresenterIMP: TweetDetailPresenter {
    
    func present() {
        
    }
    
    func set(view: TweetDetailPresentingView) {
        self.view = view
    }
    
}
