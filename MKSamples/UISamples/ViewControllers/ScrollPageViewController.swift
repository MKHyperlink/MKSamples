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
    
    private let maxPages = 3
    
    //Menu
    @IBOutlet var itemsButton: [UIButton]!
    
    //Content
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainScrollContentView: UIView!
    @IBOutlet weak var page1View: ScrollPage1!
    @IBOutlet weak var page2View: ScrollPage2!
    
    @IBOutlet weak var pageIndicator: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewInit()
    }
    
    private func viewInit() {
        mainScrollView.contentSize = mainScrollContentView.bounds.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func chagneMenuStatus(page: Int) {
        self.itemsButton.forEach({ $0.isSelected = false })
        
        guard page >= 0 && page < maxPages else { return }

        self.itemsButton[page].isSelected = true
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
    var isHorizontalScroll: Bool { true }
    
    var infiniteScrollPageLength: CGFloat {
        self.mainScrollView.frame.width
    }
    
    var infiniteScrollView: UIScrollView {
        self.mainScrollView
    }
    
    var infiniteScrollIndex: InfiniteScrollIndex {
        InfiniteScrollIndex(pageCount: maxPages, enableInfiniteScroll: false)
    }
}
