//
//  TableViewSampleViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/12/3.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

protocol TableViewSampleBehavior {
    var dataSource: [MusicInfo]? { get set }
    func search(keyword: String, completion: @escaping () -> Void)
    func getCell(index: Int) -> TableViewCellBehavior?
}

class TableViewSampleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { return "uisample_02" }
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: TableViewSampleBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewInit()
        self.dataInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func viewInit() {
        // Remove blank rows
        self.tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: "Style1TableViewCell", bundle: nil)
        self.tableView.register(nib,
                                forCellReuseIdentifier: Style1TableViewCell.IDENTIFIER)
    }
    
    private func dataInit() {
        self.viewModel = TableViewSampleViewModel()
        
        self.viewModel?.search(keyword: "jack johnson", completion: {
            self.refreshView()
        })
    }
    
    private func refreshView() {
        self.tableView.reloadData()
    }
    
    //MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.dataSource?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Style1TableViewCell.IDENTIFIER, for: indexPath) as? Style1TableViewCell else {
            return Style1TableViewCell()
        }

        if let cellViewModel = self.viewModel?.getCell(index: indexPath.row) {
            cell.setup(viewModel: cellViewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
}
