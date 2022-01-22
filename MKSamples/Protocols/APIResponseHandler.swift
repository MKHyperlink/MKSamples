//
//  APIResponseHandler.swift
//  MKSamples
//
//  Created by mike_chen on 2022/1/22.
//  Copyright © 2022 Mike. All rights reserved.
//

import Foundation
import Alamofire

protocol APIResponseHandler {
    func parseResponse<T: Decodable>(_ type: T.Type,
                                     response: AFDataResponse<Data>,
                                     completion: @escaping (_ result: T?) -> Void)
}

extension APIResponseHandler {
    func parseResponse<T: Decodable>(_ type: T.Type,
                                     response: AFDataResponse<Data>,
                                     completion: @escaping (_ result: T?) -> Void) {

        switch response.result {
        case .failure(let error):
            print(error.localizedDescription)
            print(error)
            completion(nil)
            
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                completion(model)
            } catch let jsonErr {
                print(jsonErr.localizedDescription)
                print(jsonErr)
                completion(nil)
            }
        }
    }
}
