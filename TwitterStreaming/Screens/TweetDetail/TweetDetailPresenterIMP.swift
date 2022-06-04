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
    
    var tweetDetailViewModel: TweetDetailViewModel! {
        didSet {
            self.view?.reload(tweetDetail: self.tweetDetailViewModel)
        }
    }
    
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
        self.tweetDetailViewModel = TweetDetailViewModel(tweet, delegate: self)
    }
    
    func set(view: TweetDetailPresentingView) {
        self.view = view
    }
    
}

extension TweetDetailPresenterIMP: TweetDetailViewModelDelegate {}

