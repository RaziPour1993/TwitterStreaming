//
//  LiveTweetsViewModel.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol TweetsViewModelDelegate: AnyObject {
    func didSelect(tweet: Tweet)
    func didUpdate(indexPaths: [IndexPath])
    func didReload()
}

class TweetsViewModel: TableViewModel {
    
    var sections: [TableViewSectionModel]
    var tweets: [Tweet] = []
    weak var delegate: TweetsViewModelDelegate?
    
    init(delegate: TweetsViewModelDelegate?) {
        self.sections = []
        self.delegate = delegate
    }
    
    func addNew(tweet: Tweet){
        self.tweets.insert(tweet, at: 0)
        let item = TweetCellViewModel(tweet, delegate: self)
        
        if sections.isEmpty {
            let section = TableViewSection(cellModels: [item])
            self.sections = [section]
            self.delegate?.didReload()
        } else {
            self.sections[0].cellModels.insert(item, at: 0)
            self.delegate?.didUpdate(indexPaths: [IndexPath(row: 0, section: 0)])
        }
        
    }
    
}

extension TweetsViewModel: TweetCellViewModelDelegate {
    
    func didSelect(tweet: TweetCellViewModel) {
        self.delegate?.didSelect(tweet: tweet.tweet)
    }
    
}
