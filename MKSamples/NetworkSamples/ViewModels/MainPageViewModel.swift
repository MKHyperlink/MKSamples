//
//  RestfulHandleViewModel.swift
//  MKSamples
//
//  Created by Mike on 2018/9/17.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation

class RestfulHandleViewModel {
    
    private var manager: CommandManager
    
    init() {
        self.manager = CommandManager(type: .NetworkSample)
    }
    
    func startTestRestfulAPI(completion: @escaping (_ user: User?)->Void ) {
        self.manager.getUsers { (user) in
            completion(user)
        }
    }
}
