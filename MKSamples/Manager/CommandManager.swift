//
//  CommandManager.swift
//  MKSamples
//
//  Created by Mike on 2018/9/17.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation
import Alamofire

public class CommandManager: APIResponseHandler {
    
    enum ManagerType {
        case NetworkSample
        case UISample
    }
    
    private let STATUS_SUCCSSS = "success"
    private var BASE_URL = "https://jsonplaceholder.typicode.com"
    
//    public static let instance = CommandManager()
    init(type: ManagerType) {
        switch type {
        case .NetworkSample:
            BASE_URL = "https://jsonplaceholder.typicode.com"
        case .UISample:
            // http://resources.organicfruitapps.com/documentation/itunes-store-web-service-search-api/
            BASE_URL = "https://itunes.apple.com"
        }
    }
    
    public func getUsers(completion: @escaping (_ user: User?)->Void ) {
        let url = "\(BASE_URL)/users/1"
        let headers = HTTPHeaders()
        let parameters = [String: Any]()
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
            self.parseResponse(User.self, response: response, completion: completion)
        }
    }
    
    public func searchMusic(keyword: String, completion: @escaping (_ searchResult: SearchResult?)->Void ) {
        
        let keyword = keyword.replacingOccurrences(of: " ", with: "+")
        let url = "\(BASE_URL)/search?term=\(keyword)"
        let headers = HTTPHeaders()
        let parameters = [String: Any]()
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
            self.parseResponse(SearchResult.self, response: response, completion: completion)
        }
    }
}
