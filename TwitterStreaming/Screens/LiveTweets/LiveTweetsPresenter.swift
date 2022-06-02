//
//  LiveTweetsPresenter.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol LiveTweetsPresenter: Presenter, LiveTweetsScreenManeger {
    func set(view: LiveTweetsPresentingView)
    func didTapRules()
}

protocol LiveTweetsPresentingView: PresentingView {
    func updated(tweets viewModel: TableViewModel)
}

protocol LiveTweetsScreenDelegate: ScreenDelegate {
    func didSelect(tweet: Tweet)
    func openRules()
}

protocol LiveTweetsScreenManeger: ScreenManeger {
    
}
