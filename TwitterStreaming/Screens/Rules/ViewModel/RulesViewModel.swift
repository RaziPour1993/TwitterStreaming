//
//  LiveRulesViewModel.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol RulesViewModelDelegate: AnyObject {
    func didDelete(rule: Rule)
}

class RulesViewModel: TableViewModel {
    
    var sections: [TableViewSectionModel]!
    
    private weak var delegate: RulesViewModelDelegate?
    
    init(delegate: RulesViewModelDelegate?) {
        self.sections = []
        self.delegate = delegate
    }
    
    init(_ rules: Rules, delegate: RulesViewModelDelegate?) {
        
        self.delegate = delegate
        let items =  rules.map { item in
            return RuleCellViewModel(item, delegate: self)
        }
        
        let section = TableViewSection(cellModels: items)
        self.sections = [section]
    }
    
}

extension RulesViewModel: RuleCellViewModelDelegate {
    
    func didDelete(rule: Rule) {
        self.delegate?.didDelete(rule: rule)
    }
    
}
