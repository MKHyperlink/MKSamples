//
//  ViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/9/4.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnStartAct(_ sender: Any) {
        self.switchToEffectsPage()
    }
    @IBAction func btnJsonAct(_ sender: Any) {
        self.switchToResfulTestPage()
    }
    
    //MARK: - switch page
    private func switchToEffectsPage() {
        if let vc = EffectsViewController.instantiate() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func switchToResfulTestPage() {
        if let vc = RestfulHandleViewController.instantiate() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

