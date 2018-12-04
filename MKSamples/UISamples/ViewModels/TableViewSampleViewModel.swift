//
//  TableViewSampleViewModel.swift
//  MKSamples
//
//  Created by Mike on 2018/12/4.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation
import SDWebImage

class TableViewSampleViewModel: TableViewSampleBehavior {
    
    var dataSource: [MusicInfo]?
    private var manager: CommandManager
    
    init() {
        self.manager = CommandManager(type: .UISample)
    }
    
    func search(keyword: String, completion: @escaping () -> Void) {
        self.manager.searchMusic(keyword: keyword) { (searchResult) in
            
            self.dataSource = searchResult?.results
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func getCell(index: Int) -> TableViewCellBehavior? {

        var subTitle = ""
        var thumbnailUrl = ""
        
        guard let musicInfo = self.dataSource?[index] else {
            return nil
        }
        
        guard let trackName = musicInfo.trackName, let artisName = musicInfo.artistName, let collectionName = musicInfo.collectionName else {
            return nil
        }
        
        subTitle = "\(artisName) - \(collectionName)"
        if let url = musicInfo.artworkUrl100 {
            thumbnailUrl = url
        }
        
        return TableViewCell(title: trackName,
                             subTitle: subTitle,
                             thumbnailUrl: thumbnailUrl)
    }
}
