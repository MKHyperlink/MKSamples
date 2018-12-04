//
//  SearchMusic.swift
//  MKSamples
//
//  Created by Mike on 2018/12/4.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation

public struct SearchResult: Codable {
    var resultCount: Int
    var results: [MusicInfo]
}

public struct MusicInfo: Codable {
    var wrapperType: String?
    var kind: String?
    var trackName: String?
    var artistName: String?
    var collectionName: String?
    var censoredName: String?
    var artworkUrl100: String?
    var artworkUrl60:String?
    var viewURL: String?
    var previewUrl: String?
}
