//
//  TweetCellViewModel.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol TweetCellViewModelDelegate: AnyObject {
    func didSelect(tweet: TweetCellViewModel)
}

protocol TweetCellViewUpdateDelegate: AnyObject {
    
}

class TweetCellViewModel: TableViewCellModel {
    
    func identifier() -> String {
        return "TweetTableViewCell"
    }
    
    weak var viewUpdateDelegate: TweetCellViewUpdateDelegate?
    weak var delegate: TweetCellViewModelDelegate?
    
    private(set) var name: String
    private(set) var tweet: Tweet
    
    init(_ tweet: Tweet, delegate: TweetCellViewModelDelegate) {
        self.delegate = delegate
        self.tweet = tweet
        self.name = tweet.name
    }
    
}

extension TweetCellViewModel: TweetTableViewCellDelegate {
    
    func didSelectTweet() {
        self.delegate?.didSelect(tweet: self)
    }
    
}

