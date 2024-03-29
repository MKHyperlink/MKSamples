//
//  TableViewSampleViewModel.swift
//  MKSamples
//
//  Created by Mike on 2018/12/4.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation
import SDWebImage
import Alamofire


/// 定義 TableViewUI 行為
protocol TableViewSampleUIBehavior: PageStatusDisplayable {
    func updateView()
}


/// Define TableViewSample dataSource and operation delegate
protocol TableViewSampleProtocol {
    var uiBehavior: TableViewSampleUIBehavior? { get set }
    var dataSource: [MusicInfo]? { get set }
}

/// TableViewSample operations with closure style
protocol TableViewSampleOperable: TableViewSampleProtocol {
    func search(keyword: String, completion: ((_ result: [MusicInfo]?) -> Void)?)
}

/// TableViewSample operations with Swift Concurrency style
protocol TableViewSampleAsyncOperable: TableViewSampleOperable {
    func search(keyword: String) async
}




// MARK: -
// MARK: - TableViewSampleViewModel

class TableViewSampleViewModel: NSObject {
    
    weak var uiBehavior: TableViewSampleUIBehavior?
    var dataSource: [MusicInfo]?
    private var manager: CommandManager
    
    override init() {
        self.manager = CommandManager(type: .uiSample)
    }
    
}

extension TableViewSampleViewModel {
    func clearData() {
        self.dataSource?.removeAll()
        self.uiBehavior?.updateView()
    }
}

extension TableViewSampleViewModel: TableViewSampleOperable {
    func search(keyword: String, completion: ((_ result: [MusicInfo]?) -> Void)?) {
        self.clearData()
        self.uiBehavior?.showLoading(true)
        self.manager.searchMusic(keyword: keyword) { (searchResult) in
            self.uiBehavior?.showLoading(false)
            self.dataSource = searchResult?.results
            self.uiBehavior?.updateView()
            completion?(searchResult?.results)
        }
    }
    
}

extension TableViewSampleViewModel: TableViewSampleAsyncOperable {
    func search(keyword: String) async {
        self.clearData()
        self.uiBehavior?.showLoading(true)
        let result: Result<SearchResult, AFError> = await self.manager.searchMusic(keyword: keyword)
        debugPrint(result)
        switch result {
        case .success(let model):
            self.uiBehavior?.showLoading(false)
            self.dataSource = model.results
            self.uiBehavior?.updateView()
        case .failure(_):
            break
        }
    }
}



extension TableViewSampleViewModel: UITableViewDataSource {
    
    private func setup(cell: Style1TableViewCell, musicInfo: MusicInfo) {

        let trackName = musicInfo.trackName ?? ""
        let artisName = musicInfo.artistName ?? ""
        let collectionName = musicInfo.collectionName ?? ""
        
        let subTitle = "\(artisName) - \(collectionName)"
        let thumbnailUrl = musicInfo.artworkUrl100
        
        let dataModel = Style1CellDataModel(title: trackName,
                                            subTitle: subTitle,
                                            thumbnailUrl: thumbnailUrl)
        cell.setup(dataModel: dataModel)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Style1TableViewCell.identifier, for: indexPath) as! Style1TableViewCell

        if let musicInfo = self.dataSource?[indexPath.row] {
            self.setup(cell: cell, musicInfo: musicInfo)
        }
        
        return cell
    }

}
