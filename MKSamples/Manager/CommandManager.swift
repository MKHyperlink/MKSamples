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
    
    private let STATUS_SUCCSSS = "success"
    private let BASE_URL = "https://jsonplaceholder.typicode.com"
    
    private static let instance = CommandManager()
    class var getInstance: CommandManager {
        return instance
    }
    
    public func getUsers(completion: @escaping (_ user: User)->Void ) {
        let url = "\(BASE_URL)/users/1"
        let headers = [String: String]()
        let parameters = [String: Any]()
        
        DispatchQueue(label: "com.MKsamples.getUser").async {
            Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
                
                if let resVal = response.result.value {
                    do {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(User.self, from: resVal)
                        completion(user)
                    } catch let jsonErr {
                        print("json parsing error:", jsonErr)
                    }
                } else {
                    print("Get empty result of User")
                }
            }
        }
    }
}
