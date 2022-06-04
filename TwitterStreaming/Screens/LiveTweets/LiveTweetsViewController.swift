//
//  LiveTweetsViewController.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import UIKit

class LiveTweetsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LiveTweetsPresenter!
    var tableViewDataSource: TableViewDataSource!
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    init(_ presenter: LiveTweetsPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter.set(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.viewConfig()
        self.tableViewConfig()
        self.presenter.present()
    }
    
}

extension LiveTweetsViewController {
    
    func config() {
        let rulesBarButtonItem = UIBarButtonItem(title: "Rules", style: .plain, target: self, action: #selector(rulesButtonAction))
        self.navigationItem.rightBarButtonItems = [rulesBarButtonItem]
        
        self.activityIndicator.hidesWhenStopped = false
        self.activityIndicator.color = UIColor.systemBlue
        let activityIndicatorBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.stopAnimating()
        
        let retryBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "repeat"), style: .plain, target: self, action: #selector(retryButtonAction))
        activityIndicator.startAnimating()
        self.navigationItem.leftBarButtonItems = [activityIndicatorBarButtonItem, retryBarButtonItem]
        
    }
    
    func viewConfig() {
        self.navigationItem.title = "Live Tweets".localized
    }
    
    func tableViewConfig() {
        self.tableViewDataSource = TableViewDataSource()
        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.delegate = self.tableViewDataSource
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.allowsSelection = true
        self.tableView.tableFooterView = UIView()
        self.tableView.sectionHeaderHeight = 0.0
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.register(TweetTableViewCell.self)
        self.tableView.reloadData()
    }
    
    @objc func rulesButtonAction() {
        self.presenter.didTapRules()
    }
    
    @objc func retryButtonAction() {
        self.presenter.didTapRefresh()
    }
}

extension LiveTweetsViewController: LiveTweetsPresentingView {
    
    func reload(tweets viewModel: TableViewModel) {
        self.tableViewDataSource.viewModel = viewModel
        self.tableView.reloadData()
    }
    
    func update(tweets viewModel: TableViewModel, indexPaths: [IndexPath]) {
        self.tableViewDataSource.viewModel = viewModel
        self.tableView?.beginUpdates()
        self.tableView?.insertRows(at: indexPaths, with: .top)
        self.tableView?.endUpdates()
    }
    
    func didLoadingData() {
        self.activityIndicator.stopAnimating()
    }
    
    func willLoadingData() {
        self.activityIndicator.startAnimating()
    }
    
}
