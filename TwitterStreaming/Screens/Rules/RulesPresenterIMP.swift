//
//  RulesPresenterIMP.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

class RulesPresenterIMP {
    
    weak var view: RulesPresentingView?
    weak var delegate: RulesScreenDelegate?
    var service: RulesService
    
    var rulesViewModel: RulesViewModel! {
        didSet {
            self.view?.updated(rules: self.rulesViewModel)
        }
    }
    
    init(_ service: RulesService, _ delegate: RulesScreenDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    deinit {
        debugPrint("📤 deinit \(self)")
    }
    
}

extension RulesPresenterIMP: RulesPresenter {
    
    func present() {
        getRules()
    }
    
    func set(view: RulesPresentingView) {
        self.view = view
    }
    
    func didAddRule(value: String, tag: String) {
        let item = AddRules(item: Rule(value: value, tag: tag))
        self.view?.willLoadingData()
        self.service.addRules(info: item) { result in
            self.view?.didLoadingData()
            switch result {
            case .success:
                self.getRules()
            case .failure(let error):
                self.view?.warning(message: error.description)
            }
        }
    }
    
    func getRules() {
        self.view?.willLoadingData()
        self.service.retrieveRules { result in
            self.view?.didLoadingData()
            switch result {
            case .success(let items):
                self.rulesViewModel = RulesViewModel(items, delegate: self)
            case .failure(let error):
                self.view?.warning(message: error.description)
            }
        }
    }
    
}

extension RulesPresenterIMP: RulesViewModelDelegate {
    
    func didDelete(rule: Rule) {
        self.view?.willLoadingData()
        self.service.deleteRules(info: DeleteRules(rules: [rule])) { result in
            self.view?.didLoadingData()
            switch result {
            case .success:
                self.getRules()
            case .failure(let error):
                self.view?.warning(message: error.description)
            }
        }
    }
    
}

