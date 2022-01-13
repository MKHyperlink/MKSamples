//
//  CommandManager.swift
//  MKSamples
//
//  Created by Mike on 2018/9/17.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation
import Alamofire

public class CommandManager {
    
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
            BASE_URL = "https://itunes.apple.com"
        }
    }
    
    public func getUsers(completion: @escaping (_ user: User?)->Void ) {
        let url = "\(BASE_URL)/users/1"
        let headers = HTTPHeaders()
        let parameters = [String: Any]()
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
            
            guard let resVal = response.value else {
                print("Get empty result of User")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: resVal)
                
                completion(user)
            } catch let jsonErr {
                print("json parsing error:", jsonErr)
                completion(nil)
            }
        }
    }
    
    public func searchMusic(keyword: String, completion: @escaping (_ searchResult: SearchResult?)->Void ) {
        
        let keyword = keyword.replacingOccurrences(of: " ", with: "+")
        let url = "\(BASE_URL)/search?term=\(keyword)"
        let headers = HTTPHeaders()
        let parameters = [String: Any]()
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
            
            guard let resVal = response.value else {
                print("Get empty result of SearchResult")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(SearchResult.self, from: resVal)
                
                completion(searchResult)
            } catch let jsonErr {
                print("json parsing error:", jsonErr)
                completion(nil)
            }
            
        }
    }
}
