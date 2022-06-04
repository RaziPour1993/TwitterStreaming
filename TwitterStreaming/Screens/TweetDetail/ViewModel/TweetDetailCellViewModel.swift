//
//  TweetDetailCellViewModel.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol TweetDetailCellViewModelDelegate: AnyObject {}

protocol TweetDetailCellViewUpdateDelegate: AnyObject {}

class TweetDetailCellViewModel: TableViewCellModel {
    
    func identifier() -> String {
        return "TweetDetailTableViewCell"
    }
    
    weak var viewUpdateDelegate: TweetDetailCellViewUpdateDelegate?
    weak var delegate: TweetDetailCellViewModelDelegate?
    
    private(set) var profileImage: String
    private(set) var name: String
    private(set) var tweetText: String
    private(set) var username: String
    private(set) var commentCount: String
    private(set) var retweetCount: String
    private(set) var likeCount: String
    private(set) var tweet: Tweet
    private(set) var source: String
    private(set) var hashtags: String
    private(set) var url: URL?
    private(set) var openInTwitter: Bool = false
    
    init(_ tweet: Tweet, delegate: TweetDetailCellViewModelDelegate) {
        self.delegate = delegate
        self.tweet = tweet
        
        self.profileImage = tweet.profileImage
        self.name = tweet.name
        self.tweetText = tweet.tweetText
        self.username = tweet.username
        self.commentCount = tweet.commentCount
        self.retweetCount = tweet.retweetCount
        self.likeCount = tweet.likeCount
        self.source = tweet.source
        self.hashtags = tweet.hashtags
        if  let url = URL(string: tweet.url) {
            self.url = url
            openInTwitter = true
        }
    }
    
}

extension TweetDetailCellViewModel: TweetDetailTableViewCellDelegate {}
