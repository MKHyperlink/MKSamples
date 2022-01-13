//
//  ScrollPageViewController.swift
//  MKSamples
//
//  Created by Mike on 2018/12/13.
//  Copyright © 2018 Mike. All rights reserved.
//

import UIKit

class ScrollPageViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { return "uisample_scroll_page" }
    
    private let MAX_PAGES = 3
    
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
    
    private func chagneMenuStatus(page: Int) {
        self.btnItems.forEach({ $0.isSelected = false })
        
        guard page >= 0 && page < MAX_PAGES else { return }

        self.btnItems[page].isSelected = true
        self.pageIndicator.currentPage = page
    }
    
    //MARK:- button action
    @IBAction func btnItemAct(_ sender: UIButton) {
        let page = sender.tag
        self.chagneMenuStatus(page: page)
        self.scrollToPage(page: page)
    }
}
 

extension ScrollPageViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating (_ scrollView: UIScrollView) {
        let currentPage = self.infiniteScroll(offset: scrollView.contentOffset.x)
        self.chagneMenuStatus(page: currentPage)
    }
}



extension ScrollPageViewController: InfiniteScrollable {
    var infiniteScrollPageLength: CGFloat {
        self.srlVwMain.frame.width
    }
    
    var infiniteScrollView: UIScrollView {
        self.srlVwMain
    }
    
    var infiniteScrollIndex: InfiniteScrollIndex {
        InfiniteScrollIndex(pageCount: MAX_PAGES, enableInfiniteScroll: false)
    }
}
