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
    static let IDENTIFIER = "InfiniteScrollCell"
    
    @IBOutlet weak var indexLabel: UILabel!
}


// MARK: -
// MARK: - InfinitScrollVC

class InfinitScrollVC: UIViewController, StoryboardInstantiable {
    
    static var storyboardName: String { return "UISamples" }
    static var storyboardIdentifier: String? { "uisample_scroll_page2" }
    
    @IBOutlet weak var cltVw: UICollectionView!
    
    private let colors: [UIColor] = [.yellow, .cyan, .purple, .blue, .white, .brown]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollToPage(page: self.infiniteScrollIndex.realStartPage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}


extension InfinitScrollVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = collectionView.frame.width
        let h:CGFloat = collectionView.frame.height
        return CGSize(width: w, height: h)
    }
    
}

extension InfinitScrollVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.infiniteScrollIndex.pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfiniteScrollCell.IDENTIFIER, for: indexPath) as? InfiniteScrollCell else {
            return UICollectionViewCell()
        }
        
        let idx = self.infiniteScrollMappingToSourceIndex(fromPage: indexPath.section)
        cell.indexLabel.text = String(idx)
        cell.backgroundColor = self.colors[idx]
        
        return cell
    }
}


extension InfinitScrollVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 根據滾動方向傳入 scrollView.contentOffset.y / scrollView.contentOffset.x
        let currentPage = self.infiniteScroll(offset: scrollView.contentOffset.y)
        print("Current page:", currentPage)
    }
}


extension InfinitScrollVC: InfiniteScrollable {
    var infiniteScrollSetting: InfiniteScrollSetting {
        InfiniteScrollSetting(isHorizontalScroll: false)
    }
    
    var infiniteScrollView: UIScrollView {
        self.cltVw
    }
    
    var infiniteScrollPageLength: CGFloat {
        self.cltVw.frame.height
    }
    
    var infiniteScrollIndex: InfiniteScrollIndex {
        InfiniteScrollIndex(pageCount: self.colors.count,
                            enableInfiniteScroll: false)
    }
}
