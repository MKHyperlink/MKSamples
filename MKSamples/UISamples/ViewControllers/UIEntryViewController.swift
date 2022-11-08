//
//  UIEntryViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/10/9.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

class UIEntryViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { return "uisample_entry" }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - button action

    @IBAction func btnOneAct(_ sender: UIButton) {
        self.switchToShakeAndKeyboardPage()
    }
    
    @IBAction func btnTwoAct(_ sender: UIButton) {
        self.switchToTableViewPage()
    }
    
    @IBAction func btnThreeAct(_ sender: UIButton) {
        self.switchToScrollViewPage()
    }
    
    @IBAction func btnFourAct(_ sender: UIButton) {
        self.switchToInfiniteScrollViewPage()
    }
    
    //MARK: switch page
    private func switchToShakeAndKeyboardPage() {
        if let vc = EffectsViewController.instantiate() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func switchToTableViewPage() {
        if let vc = TableViewSampleViewController.instantiate() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func switchToScrollViewPage() {
        if let vc = ScrollPageViewController.instantiate() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func switchToInfiniteScrollViewPage() {
        if let vc = InfiniteScrollVC.instantiate() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
