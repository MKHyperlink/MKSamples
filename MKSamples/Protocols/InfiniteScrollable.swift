//
//  InfiniteScrollable.swift
//  GOHAPPY
//
//  Created by mike_chen on 2021/12/15.
//  Copyright © 2021 FEEC. All rights reserved.
//

import UIKit

struct InfiniteScrollSetting {
    /// 設定橫向或縱向滾動
    var isHorizontalScroll: Bool = true
    
    var isEnablePagingIndicator: Bool = true
}

struct InfiniteScrollIndex {
    /// 資料源的實際大小（不包含假首/尾頁）
    let originalPageCount: Int
    
    let isEnableInfiniteScroll: Bool
    
    var pageCount: Int {
        guard originalPageCount > 1 else { return 1 }   // 小於一頁不需循環捲動
        return isEnableInfiniteScroll ?
            originalPageCount + fakePagesCount :       // 加入假首頁與假尾頁
            originalPageCount
    }
    
    var startIdx: Int = 0
    let realIdxShift: Int = 1   // Shift 1 digit from fakeEndPage
    
    // 無限循環捲動塞入的假頁面
    var fakeEndPage: Int { startIdx }
    var fakeStartPage: Int { pageCount - (1 - startIdx) }
    let fakePagesCount: Int = 2
    
    // 實際起始頁面
    var realStartPage: Int { isEnableInfiniteScroll ? (fakeEndPage + 1) : fakeEndPage }
    var realEndPage: Int { isEnableInfiniteScroll ? (fakeStartPage - 1) : fakeStartPage }
    
    init(pageCount originalPageCount: Int, enableInfiniteScroll: Bool = true) {
        self.originalPageCount = originalPageCount
        self.isEnableInfiniteScroll = enableInfiniteScroll
    }
}

protocol InfiniteScrollable {
    /// 每個頁面滾動所需的距離
    ///
    /// - 橫向滾動（isHorizontalScroll 為 true）代入頁面寬度
    /// - 縱向滾動（isHorizontalScroll 為 false）代入頁面高度
    var infiniteScrollPageLength: CGFloat { get }
    
    /// 實作 infiniteScroll 的載體元件
    var infiniteScrollView: UIScrollView { get }
    
    /// 初始化 infiniteScroll 的 page index
    ///
    /// 定義假首頁/假尾頁的 index 轉換
    var infiniteScrollIndex: InfiniteScrollIndex { get }
    
    /// 客製化參數設定
    ///
    /// ex.  設定橫向或縱向滾動
    var infiniteScrollSetting: InfiniteScrollSetting { get }
    
}


extension InfiniteScrollable {
    
    // 使用 InfiniteScroll 設定預設值，再由覆寫值做設定變更
    var infiniteScrollSetting: InfiniteScrollSetting { InfiniteScrollSetting() }
    
    /// 滾動至指定頁面
    /// - Parameters:
    ///   - page: 要滾動到的目標頁
    ///   - animated: 滾動時是否需動畫效果
    func scrollToPage(page: Int, animated: Bool = false) {
        
        guard page >= self.infiniteScrollIndex.startIdx else { return }

        let scrollView = self.infiniteScrollView
        let directionOffset = self.infiniteScrollPageLength * CGFloat(page-self.infiniteScrollIndex.startIdx)
        let offset = self.infiniteScrollSetting.isHorizontalScroll ?
            CGPoint(x: directionOffset, y: 0) :
            CGPoint(x: 0, y: directionOffset)
        scrollView.setContentOffset(offset, animated: animated)
    }
    
    /// 處理 InfiniteScroll 的頁面切換
    ///
    /// 切換時
    /// - InfiniteScroll enable：首頁上一頁接尾頁，尾頁下一頁接首頁
    /// - InfiniteScroll disable： 逆向滾動到僅至首頁，順向滾動僅至尾頁，即無法再繼續顯示下一頁面
    /// - Parameter offset: 根據滾動方向傳入 OffsetY / OffsetX
    /// - Returns: 最後停留的 Page (Current Index)
    func infiniteScroll(offset: CGFloat) -> Int {
        let pageWidth = self.infiniteScrollPageLength
        let page = Int(floor((offset - pageWidth / 2) / pageWidth) + 1) // Start from index 0

        guard self.infiniteScrollIndex.isEnableInfiniteScroll else {
            self.scrollToPage(page: page)
            return page
        }
        
        // 在可無限循環情況下，判斷頁面是否正在假尾頁或假首頁
        if page == self.infiniteScrollIndex.fakeEndPage {               // 位於假尾頁，前捲至最尾頁
            self.scrollToPage(page: self.infiniteScrollIndex.realEndPage)
        } else if page == self.infiniteScrollIndex.fakeStartPage {      // 位於假首頁，回捲至首頁
            self.scrollToPage(page: self.infiniteScrollIndex.realStartPage)
        }
        
        return self.infiniteScrollMappingToSourceIndex(fromPage: page)
    }
    
    /// 顯示頁面和資料來源 index 轉換
    ///
    /// InfiniteScroll enable 情況下加入了假頁首頁尾，實際 index 會位移
    /// - Parameter page: Page index（start from InfiniteScrollIndex.startIdx）
    /// - Returns: Source data index 
    func infiniteScrollMappingToSourceIndex(fromPage page: Int) -> Int {
        var sourceIndex = page
        
        guard self.infiniteScrollIndex.isEnableInfiniteScroll else {
            return sourceIndex
        }
        
        if page == self.infiniteScrollIndex.fakeEndPage {
            sourceIndex = self.infiniteScrollIndex.realEndPage
        } else if page == self.infiniteScrollIndex.fakeStartPage {
            sourceIndex = self.infiniteScrollIndex.realStartPage
        }
        
        sourceIndex -= self.infiniteScrollIndex.realIdxShift

        guard sourceIndex >= 0 else { return 0 }
        guard sourceIndex < self.infiniteScrollIndex.originalPageCount else {
            return self.infiniteScrollIndex.originalPageCount - 1
        }
     
        return sourceIndex
    }
}

