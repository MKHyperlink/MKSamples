//
//  RestfulHandleViewModel.swift
//  MKSamples
//
//  Created by Mike on 2018/9/17.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation

class RestfulHandleViewModel {
    
    func startTestRestfulAPI(completion: @escaping (_ user: User)->Void ) {
        CommandManager.getInstance.getUsers { (user) in
            print("email:", user.email)
            print("username:", user.username)
            print("name:", user.name)
            print("company bs:", user.company.bs)
            
            completion(user)
        }
    }
}
