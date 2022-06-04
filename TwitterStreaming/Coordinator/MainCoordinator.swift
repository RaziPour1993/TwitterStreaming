import Foundation

final class MainCoordinator: Coordinator {
    
    var screenFactory: ScreenFactory
    var coordinatorFactory: CoordinatorFactory
    var router: Router
    
    init(_ coordinatorFactory: CoordinatorFactory, _ screenFactory: ScreenFactory, _ router: Router) {
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    func start() {
        startIntroCoordinator()
    }
    
    deinit {
        debugPrint("📤 deinit \(self)")
    }
    
}

extension MainCoordinator: IntroCoordinatorDelegate {
    
    func didFinish(coordinator: IntroCoordinator) {
        self.coordinatorFactory.removeChildCoordinator(coordinator)
        self.startLiveTweetsCoordinator()
    }
    
    func startIntroCoordinator() {
        let coordinator = self.coordinatorFactory.makeIntroCoordinator(delegate: self)
        coordinator.start()
    }
    
}

extension MainCoordinator: LiveTweetsCoordinatorDelegate {
    
    func startLiveTweetsCoordinator() {
        let coordinator = self.coordinatorFactory.makeLiveTweetsCoordinator(delegate: self)
        coordinator.start()
    }
    
}
