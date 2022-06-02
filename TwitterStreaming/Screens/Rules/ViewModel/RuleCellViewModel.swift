//
//  RuleCellViewModel.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol RuleCellViewModelDelegate: AnyObject {
    func didDelete(rule: Rule)
}

protocol RuleCellViewUpdateDelegate: AnyObject {
    
}

class RuleCellViewModel: TableViewCellModel {
    
    func identifier() -> String {
        return "RuleTableViewCell"
    }
    
    weak var viewUpdateDelegate: RuleCellViewUpdateDelegate?
    weak var delegate: RuleCellViewModelDelegate?
    
    private(set) var value: String
    private(set) var tag: String
    private(set) var rule: Rule
    
    init(_ rule: Rule, delegate: RuleCellViewModelDelegate) {
        self.delegate = delegate
        self.rule = rule
        self.tag = rule.tag
        self.value = rule.value
    }
    
}

extension RuleCellViewModel: RuleTableViewCellDelegate {
    
    func didTapDeleteRule() {
        self.delegate?.didDelete(rule: rule)
    }
    
}



