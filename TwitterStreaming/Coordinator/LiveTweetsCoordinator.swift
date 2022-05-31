//
//  LiveTweetsCoordinator.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol LiveTweetsCoordinatorDelegate: CoordinatorDelegate {
    
}

final class LiveTweetsCoordinator: Coordinator {
    
    var screenFactory: ScreenFactory
    var coordinatorFactory: CoordinatorFactory
    var router: Router
    weak var delegate: LiveTweetsCoordinatorDelegate?
    
    init(_ delegate: LiveTweetsCoordinatorDelegate, _ coordinatorFactory: CoordinatorFactory, _ screenFactory: ScreenFactory, _ router: Router) {
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
        self.delegate = delegate
    }
    
    func start() {
        self.displayLiveTweetsScreen()
    }
    
    deinit {
        debugPrint("📤 deinit \(self)")
    }
    
}

extension LiveTweetsCoordinator: LiveTweetsScreenDelegate {
    
    func didSelect(tweet: Tweet) {
        self.displayTweetDetailScreen(tweet: tweet)
    }
    
    func displayLiveTweetsScreen() {
        let screen = self.screenFactory.makeLiveTweetsScreen(delegate: self)
        self.router.setRoot(screen, with: true)
    }
    
}


extension LiveTweetsCoordinator: TweetDetailScreenDelegate {
    
    func displayTweetDetailScreen(tweet: Tweet) {
        let screen = self.screenFactory.makeTweetDetailScreen(delegate: self, tweet)
        self.router.push(screen)
    }
    
}
