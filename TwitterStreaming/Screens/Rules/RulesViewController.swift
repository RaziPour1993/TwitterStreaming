//
//  RulesViewController.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import UIKit

class RulesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var presenter: RulesPresenter!
    var tableViewDataSource: TableViewDataSource!
    
    init(_ presenter: RulesPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter.set(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        viewConfig()
        tableViewConfig()
        presenter.present()
    }
    
}

extension RulesViewController {
    
    func config() {
        let addRuleBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addRuleButtonAction))
        
        self.activityIndicator.color = UIColor.systemBlue
        let activityIndicatorBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.stopAnimating()
        
        self.navigationItem.rightBarButtonItems = [addRuleBarButtonItem, activityIndicatorBarButtonItem]
        
    }
    
    func viewConfig() {
        self.navigationItem.title = "Rules".localized
    }
    
    func tableViewConfig() {
        self.tableViewDataSource = TableViewDataSource()
        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.delegate = self.tableViewDataSource
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = UIView()
        self.tableView.sectionHeaderHeight = 0.0
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.allowsSelection = false
        self.tableView.register(RuleTableViewCell.self)
    }
    
    @objc func addRuleButtonAction() {
        let alert = UIAlertController(title: title, message: "Please enter value and tag", preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = "Value".localized
        }
        
        alert.addTextField() { newTextField in
            newTextField.placeholder = "Tag".localized
        }
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel) { _ in })
        alert.addAction(UIAlertAction(title: "Add".localized, style: .default) { action in
            let textFields = alert.textFields
            guard let value = textFields?.first?.text, !value.isEmpty , let tag = textFields?.last?.text, !tag.isEmpty else {
                return
            }
            
            self.presenter.didAddRule(value: value, tag: tag)
        })
        navigationController?.present(alert, animated: true)
    }
    
}

extension RulesViewController: RulesPresentingView {
    
    func updated(rules viewModel: TableViewModel) {
        self.tableViewDataSource.viewModel = viewModel
        self.tableView.reloadData()
    }
    
    func willLoadingData() {
        self.activityIndicator.startAnimating()
    }
    
    func didLoadingData() {
        self.activityIndicator.stopAnimating()
    }
    
}
