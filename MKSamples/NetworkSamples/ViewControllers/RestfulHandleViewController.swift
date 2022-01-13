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
    
    private var viewModel: RestfulHandler?
    
    @IBOutlet weak var idctrLoading: UIActivityIndicatorView!
    @IBOutlet weak var ttvwResopnse: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewInit()
        self.dataInit()
    }
    
    private func dataInit() {
        self.viewModel = MainPageViewModel()
        self.viewModel?.uiBehavior = self
    }
    
    private func viewInit() {
        self.idctrLoading.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func startTest() {
        self.viewModel?.startTest(completion: nil)
    }
    
    
    // MARK: - button actions
    
    @IBAction func btnJsonTestAct(_ sender: Any) {
        self.startTest()
    }
    
}


extension RestfulHandleViewController: RestfulHandlerUIBehavior {
    func resetView() {
        self.ttvwResopnse.text = ""
    }
    
    func updateView(user: User?) {
        guard let user = user,
              let data = try? JSONEncoder().encode(user) else { return }
        
        self.ttvwResopnse.text = String(decoding: data, as: UTF8.self)
    }
    
    func showLoading(_ status: Bool) {
        status ? self.idctrLoading.startAnimating() : self.idctrLoading.stopAnimating()
    }
}
