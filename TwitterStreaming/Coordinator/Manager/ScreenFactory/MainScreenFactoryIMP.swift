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
    
    
}


