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
    @IBOutlet weak var idctrLoading: UIActivityIndicatorView!
    
    private var viewModel: (TableViewSampleHandler &
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
        self.tableView.register(nib, forCellReuseIdentifier: Style1TableViewCell.IDENTIFIER)
        
        self.idctrLoading.hidesWhenStopped = true
    }
    
    private func dataInit() {
        self.viewModel = TableViewSampleViewModel()
        self.viewModel?.uiBehavior = self
        self.tableView.dataSource = self.viewModel
        
    }
    
    private func fetchData() {
        let keyword = "kurakimai"
        self.viewModel?.search(keyword: keyword, completion: nil)
    }
    
}


// MARK: - TableViewSampleUIBehavior
extension TableViewSampleViewController: TableViewSampleUIBehavior {
    func showLoading(_ status: Bool) {
        status ? self.idctrLoading.startAnimating() : self.idctrLoading.stopAnimating()
    }
    
    func updateView() {
        self.tableView.reloadData()
    }
}
