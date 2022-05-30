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
        print(self)
    }
    
}

extension MainCoordinator: IntroCoordinatorDelegate {
    
    func didFinish(coordinator: IntroCoordinator) {
//        self.coordinatorFactory.removeChildCoordinator(coordinator)
    }
    
    func startIntroCoordinator() {
        let coordinator = self.coordinatorFactory.makeIntroCoordinator(delegate: self)
        coordinator.start()
    }
    
}
