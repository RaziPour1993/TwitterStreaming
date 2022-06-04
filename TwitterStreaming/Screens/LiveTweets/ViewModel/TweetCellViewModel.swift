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
    
    private(set) var profileImage: String
    private(set) var name: String
    private(set) var tweetText: String
    private(set) var username: String
    private(set) var commentCount: String
    private(set) var retweetCount: String
    private(set) var likeCount: String
    private(set) var tweet: Tweet
    
    init(_ tweet: Tweet, delegate: TweetCellViewModelDelegate) {
        self.delegate = delegate
        self.tweet = tweet
        
        self.profileImage = tweet.profileImage
        self.name = tweet.name
        self.tweetText = tweet.tweetText
        self.username = tweet.username
        self.commentCount = tweet.commentCount
        self.retweetCount = tweet.retweetCount
        self.likeCount = tweet.likeCount
    }
    
}

extension TweetCellViewModel: TweetTableViewCellDelegate {
    
    func didSelectTweet() {
        self.delegate?.didSelect(tweet: self)
    }
    
}

