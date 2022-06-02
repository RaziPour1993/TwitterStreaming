//
//  RulesPresenter.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol RulesPresenter: Presenter {
    func set(view: RulesPresentingView)
    func didAddRule(value: String, tag: String)
}

protocol RulesPresentingView: PresentingView {
    func updated(rules viewModel: TableViewModel)
}

protocol RulesScreenDelegate: ScreenDelegate {
    
}
