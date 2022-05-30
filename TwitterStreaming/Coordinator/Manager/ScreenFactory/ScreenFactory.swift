import Foundation

protocol ScreenFactory {
    
    func makeIntroScreen(delegate: IntroScreenDelegate)-> IntroViewController
    func makeLiveTweetsScreen(delegate: LiveTweetsScreenDelegate)-> LiveTweetsViewController
    
}
