//
//  TweetDetailViewController.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import UIKit

class TweetDetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TweetDetailPresenter!
    var tableViewDataSource: TableViewDataSource!
    
    init(_ presenter: TweetDetailPresenter) {
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

extension TweetDetailViewController {
    
    func config() {
        
    }
    
    func viewConfig() {
        self.navigationItem.title = "Tweet Detail".localized
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
        self.tableView.register(TweetTableViewCell.self)
    }
    
}

extension TweetDetailViewController: TweetDetailPresentingView {
    
    func updated(tweetDetail viewModel: TableViewModel) {
        self.tableViewDataSource.viewModel = viewModel
        self.tableView.reloadData()
    }
    
}
