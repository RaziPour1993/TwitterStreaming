import UIKit

final class MainScreenFactoryIMP: ScreenFactory {
    
    init() {
        
    }
    
    func makeIntroScreen(delegate: IntroScreenDelegate) -> IntroViewController {
        let presenter = IntroPresenterIMP(delegate)
        let screen = IntroViewController(presenter)
        return screen
    }
    
    func makeLiveTweetsScreen(delegate: LiveTweetsScreenDelegate) -> LiveTweetsViewController {
        let service = LiveTweetsServiceIMP()
        let presenter = LiveTweetsPresenterIMP(service, delegate)
        let screen = LiveTweetsViewController(presenter)
        return screen
    }
    
    func makeTweetDetailScreen(delegate: TweetDetailScreenDelegate, _ tweet: Tweet) -> TweetDetailViewController {
        let presenter = TweetDetailPresenterIMP(tweet, delegate)
        let screen = TweetDetailViewController(presenter)
        return screen
    }
    
    func makeRulesScreen(delegate: RulesScreenDelegate) -> RulesViewController {
        let service = RulesServiceIMP()
        let presenter = RulesPresenterIMP(service, delegate)
        let screen = RulesViewController(presenter)
        return screen
    }
    
}


