//
//  LiveTweetDetailViewModel.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol TweetDetailViewModelDelegate: AnyObject {}

class TweetDetailViewModel: TableViewModel {
    
    var sections: [TableViewSectionModel]
    var TweetDetail: [Tweet] = []
    weak var delegate: TweetDetailViewModelDelegate?
    
    init(_ tweet: Tweet, delegate: TweetDetailViewModelDelegate?) {
        self.sections = []
        self.delegate = delegate
        let item = TweetDetailCellViewModel(tweet, delegate: self)
        let section = TableViewSection(cellModels: [item])
        self.sections = [section]
    }
    
}

extension TweetDetailViewModel: TweetDetailCellViewModelDelegate {}
