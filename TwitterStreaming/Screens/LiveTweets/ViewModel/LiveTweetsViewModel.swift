//
//  LiveTweetsViewModel.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol TweetsViewModelDelegate: AnyObject {
    func didSelect(tweet: Tweet)
}

class TweetsViewModel: TableViewModel {
    
    var sections: [TableViewSectionModel]!
    var tweets: Tweets!
    
    private weak var delegate: TweetsViewModelDelegate?
    
    init(delegate: TweetsViewModelDelegate?) {
        self.sections = []
        self.delegate = delegate
    }
    
    init(_ tweets: Tweets, delegate: TweetsViewModelDelegate?) {
        self.tweets = tweets
        self.delegate = delegate
        let items =  self.tweets.map { item in
            return TweetCellViewModel(item, delegate: self)
        }
        
        let section = TableViewSection(cellModels: items)
        self.sections = [section]
    }
    
}

extension TweetsViewModel: TweetCellViewModelDelegate {

    func didSelect(tweet: TweetCellViewModel) {
        self.delegate?.didSelect(tweet: tweet.tweet)
    }
    
}
