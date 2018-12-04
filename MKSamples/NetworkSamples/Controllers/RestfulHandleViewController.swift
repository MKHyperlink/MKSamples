//
//  RestfulHandleViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/9/17.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

class RestfulHandleViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String { return "NetworkSamples" }
    static var storyboardIdentifier: String? { return "NetworkSamples_01" }
    
    let viewModel = RestfulHandleViewModel()
    
    @IBOutlet weak var idctrLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.idctrLoading.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func startTest() {
        self.idctrLoading.startAnimating()
        self.viewModel.startTestRestfulAPI { [weak self] user in
            
            if let user = user {
                print("email:", user.email)
                print("username:", user.username)
                print("name:", user.name)
                print("company bs:", user.company.bs)
            }
            
            self?.idctrLoading.stopAnimating()
        }
    }
    
    //MARK: - button actions
    
    @IBAction func btnJsonTestAct(_ sender: Any) {
        self.startTest()
    }
    
}
