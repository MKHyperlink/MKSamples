//
//  TableViewSampleViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/12/3.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

class TableViewSampleViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { return "uisample_tableview" }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    private var viewModel: (TableViewSampleProtocol &
                            TableViewSampleOperable &
                            TableViewSampleAsyncOperable &
                            UITableViewDataSource)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataInit()
        self.viewInit()
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func viewInit() {
        // Remove blank rows
        self.tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: "Style1TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: Style1TableViewCell.identifier)
        
        self.loadingIndicatorView.hidesWhenStopped = true
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self,
                                                 action: #selector(fetchData),
                                                 for: .valueChanged)
    }
    
    private func dataInit() {
        self.viewModel = TableViewSampleViewModel()
        self.viewModel?.uiBehavior = self
        self.tableView.dataSource = self.viewModel
    }

    @objc
    private func fetchData() {
        let keyword = "kurakimai"
//        self.viewModel?.search(keyword: keyword, completion: nil)
        Task {
            await self.viewModel?.search(keyword: keyword)
        }
    }
    
}


// MARK: - TableViewSampleUIBehavior
extension TableViewSampleViewController: TableViewSampleUIBehavior {
    func showLoading(_ isOn: Bool) {
        DispatchQueue.main.async {
            if isOn {
                if !(self.tableView.refreshControl?.isRefreshing ?? false) {
                    self.loadingIndicatorView.startAnimating()
                }
            } else {
                self.tableView.refreshControl?.endRefreshing()
                self.loadingIndicatorView.stopAnimating()
            }
        }
    }
    
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
