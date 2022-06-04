//
//  LiveTweetsPresenterIMP.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

class LiveTweetsPresenterIMP {
    
    weak var view: LiveTweetsPresentingView?
    weak var delegate: LiveTweetsScreenDelegate?
    var service: LiveTweetsService
    
    var tweetsViewModel: TweetsViewModel! {
        didSet {
            self.view?.reload(tweets: self.tweetsViewModel)
        }
    }
    
    init(_ service: LiveTweetsService, _ delegate: LiveTweetsScreenDelegate?) {
        self.delegate = delegate
        self.service = service
        self.tweetsViewModel = TweetsViewModel(delegate: self)
    }
    
    deinit {
        debugPrint("📤 deinit \(self)")
    }
    
}

extension LiveTweetsPresenterIMP: LiveTweetsPresenter {
    
    func present() {
        self.startStream()
    }
    
    func set(view: LiveTweetsPresentingView) {
        self.view = view
    }
    
    func didTapRules() {
        self.delegate?.openRules()
    }
    
    func didTapRefresh() {
        self.service.stopStream { result in
            self.view?.didLoadingData()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.startStream()
//            }
        }
    }
    
    func startStream(){
        self.view?.willLoadingData()
        self.service.startStream(with: StreamFilter()) { result in
            switch result {
            case .success(let tweet):
                self.tweetsViewModel.addNew(tweet: tweet)
            case .failure:
                self.view?.didLoadingData()
            }
        }
    }
    
}

extension LiveTweetsPresenterIMP: TweetsViewModelDelegate {
    
    func didUpdate(indexPaths: [IndexPath]) {
        self.view?.update(tweets: self.tweetsViewModel, indexPaths: indexPaths)
    }
    
    func didReload() {
        self.view?.reload(tweets: self.tweetsViewModel)
    }
    
    func didSelect(tweet: Tweet) {
        self.delegate?.didSelect(tweet: tweet)
    }
    
}
