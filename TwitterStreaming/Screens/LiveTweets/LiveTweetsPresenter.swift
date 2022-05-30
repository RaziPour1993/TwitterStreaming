//
//  LiveTweetsPresenter.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol LiveTweetsPresenter: Presenter, LiveTweetsScreenManeger {
    func set(view: LiveTweetsPresentingView)
}

protocol LiveTweetsPresentingView: PresentingView {

}

protocol LiveTweetsScreenDelegate: ScreenDelegate {
    
}

protocol LiveTweetsScreenManeger: ScreenManeger {
    
}
