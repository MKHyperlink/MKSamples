//
//  InfinitScrollVC.swift
//  GOHAPPY
//
//  Created by mike_chen on 2021/12/15.
//  Copyright © 2021 FEEC. All rights reserved.
//

import UIKit

// MARK: -
// MARK: - InfiniteScrollCell

class InfiniteScrollCell: UICollectionViewCell {
    static let identifier = "InfiniteScrollCell"
    
    @IBOutlet weak var indexLabel: UILabel!
}


// MARK: -
// MARK: - InfinitScrollVC

class InfiniteScrollVC: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { "uisample_scroll_page2" }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infiniteScrollSwitchButton: UISwitch!
    @IBOutlet weak var horizontalScrollSwitchButton: UISwitch!
    
    private let colors: [UIColor] = [.yellow, .cyan, .purple, .blue, .orange, .brown]
    
    
    // MARK: - InfiniteScrollable implementation
    var isHorizontalScroll: Bool = true {
        didSet {
            self.horizontalScrollSwitchButton.isOn = self.isHorizontalScroll
            let direction: UICollectionView.ScrollDirection = self.isHorizontalScroll ? .horizontal : .vertical
            self.changeScrollDirection(direction)
            self.collectionView.reloadData()
        }
    }
    // MARK: -
    
    var isInfiniteScroll: Bool = true {
        didSet {
            self.infiniteScrollSwitchButton.isOn = self.isInfiniteScroll
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewInit()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollToPage(page: self.infiniteScrollIndex.realStartPage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func viewInit() {
        let direction: UICollectionView.ScrollDirection = self.isHorizontalScroll ? .horizontal : .vertical
        self.changeScrollDirection(direction)
    }
    
    private func changeScrollDirection(_ direction: UICollectionView.ScrollDirection) {
        (self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = direction
    }
    
    @IBAction func pressHorizontalSwitch(_ sender: UISwitch) {
        self.isHorizontalScroll = sender.isOn
    }
    @IBAction func pressInfiniteSwitch(_ sender: UISwitch) {
        self.isInfiniteScroll = sender.isOn
    }
}


extension InfiniteScrollVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = collectionView.frame.width
        let h:CGFloat = collectionView.frame.height
        return CGSize(width: w, height: h)
    }
    
}

extension InfiniteScrollVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.infiniteScrollIndex.pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfiniteScrollCell.identifier, for: indexPath) as? InfiniteScrollCell else {
            return UICollectionViewCell()
        }
        
        let idx = self.infiniteScrollMappingToSourceIndex(fromPage: indexPath.section)
        cell.indexLabel.text = String(idx)
        cell.backgroundColor = self.colors[idx]
        
        return cell
    }
}


extension InfiniteScrollVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = self.isHorizontalScroll ? scrollView.contentOffset.x : scrollView.contentOffset.y
        let currentPage = self.infiniteScroll(offset: offset)
        debugPrint("Current page:", currentPage)
    }
}


extension InfiniteScrollVC: InfiniteScrollable {
    var infiniteScrollView: UIScrollView {
        self.collectionView
    }
    
    var infiniteScrollPageLength: CGFloat {
        self.isHorizontalScroll ? self.collectionView.frame.width : self.collectionView.frame.height
    }
    
    var infiniteScrollIndex: InfiniteScrollIndex {
        InfiniteScrollIndex(pageCount: self.colors.count,
                            enableInfiniteScroll: self.isInfiniteScroll)
    }
}
