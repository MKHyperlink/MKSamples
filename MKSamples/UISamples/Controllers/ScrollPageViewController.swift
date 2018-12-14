//
//  ScrollPageViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/12/13.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

class ScrollPageViewController: UIViewController, UIScrollViewDelegate, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { return "uisample_scroll_page" }
    
    let MAX_PAGES = 3
    
    //Menu
    @IBOutlet var btnItems: [UIButton]!
    
    //Content
    @IBOutlet weak var srlVwMain: UIScrollView!
    @IBOutlet weak var vwMainContent: UIView!
    @IBOutlet weak var vwPage1: ScrollPage1!
    @IBOutlet weak var vwPage2: ScrollPage2!
    
    @IBOutlet weak var pageIndicator: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewInit()
    }
    
    private func viewInit() {
        srlVwMain.contentSize = vwMainContent.bounds.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func chagneMenuStatus(page: Int) {
        let _ = self.btnItems.map(){ $0.isSelected = false }
        
        if page > 0 && page <= MAX_PAGES {
            self.btnItems[page-1].isSelected = true
            self.pageIndicator.currentPage = page-1
        }
    }
    
    func scrollToPage(page: Int) {
        var contentOffset = CGPoint(x: 0, y: 0)
        contentOffset.x = srlVwMain.frame.width * CGFloat(page-1);
        srlVwMain.setContentOffset(contentOffset, animated: true)
    }
    
    //MARK:- button action
    @IBAction func btnItemAct(_ sender: UIButton) {
        let page = sender.tag
        chagneMenuStatus(page: page)
        scrollToPage(page: page)
    }
    
    //MARK:- UIScrollViewDelegate
    public func scrollViewDidEndDecelerating (_ scrollView: UIScrollView) {
        
        // Update the page when more than 50% of the previous/next page is visible
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2)
        chagneMenuStatus(page: page)
    }

}
