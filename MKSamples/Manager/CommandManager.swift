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
    private var urlComponent: URLComponents?
    
//    public static let instance = CommandManager()
    init(type: ManagerType) {
        switch type {
        case .NetworkSample:
            urlComponent = URLComponents(string: "https://jsonplaceholder.typicode.com")
        case .UISample:
            // http://resources.organicfruitapps.com/documentation/itunes-store-web-service-search-api/
            urlComponent = URLComponents(string: "https://itunes.apple.com")
        }
    }
    
    public func getUsers(completion: @escaping (_ user: User?)->Void ) {
        urlComponent?.path = "/users/1"
        guard let url = urlComponent?.url?.absoluteURL else { return }
        
        let headers = HTTPHeaders()
        let parameters = [String: Any]()
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
            self.parseResponse(User.self, response: response, completion: completion)
        }
    }
    
    private func searchMusicUrl(keyword: String) -> String? {
        let keyword = keyword.replacingOccurrences(of: " ", with: "+")
        urlComponent?.path = "/search"
        urlComponent?.queryItems = [URLQueryItem(name: "term", value: keyword)]
        return urlComponent?.url?.absoluteString
    }
    
    public func searchMusic(keyword: String, completion: @escaping (_ searchResult: SearchResult?)->Void ) {
        guard let url = searchMusicUrl(keyword: keyword) else { return }
        let headers = HTTPHeaders()
        let parameters = [String: Any]()
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
            self.parseResponse(SearchResult.self, response: response, completion: completion)
        }
    }
    
    public func searchMusic<T: Decodable>(keyword: String) async -> Result<T, AFError> {
        guard let url = searchMusicUrl(keyword: keyword) else {
            return Result.failure(AFError.invalidURL(url: ""))
        }
        
        let headers = HTTPHeaders()
        let parameters = [String: Any]()
        
        return await AF.request(url,
                                method: .get,
                                parameters: parameters,
                                headers: headers)
        .serializingDecodable(T.self)
        .result
    }
}
