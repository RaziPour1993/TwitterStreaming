//
//  TweetDetailPresenter.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol TweetDetailPresenter: Presenter {
    func set(view: TweetDetailPresentingView)
}

protocol TweetDetailPresentingView: PresentingView {
    func updated(tweetDetail viewModel: TableViewModel)
}

protocol TweetDetailScreenDelegate: ScreenDelegate {
    
}
