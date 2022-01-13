//
//  MainPageViewModel.swift
//  MKSamples
//
//  Created by Mike on 2018/9/17.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation


/// 定義 UI 行為
protocol RestfulHandlerUIBehavior: PageStatusDisplayable {
    func resetView()
    func updateView(user: User?)
}

/// 定義操作行為
protocol RestfulHandler {
    var uiBehavior: RestfulHandlerUIBehavior? { get set }
    
    func startTest(completion: ((_ user: User?)->Void)?)
}




// MARK: -
// MARK: - MainPageViewModel

class MainPageViewModel {
    
    weak var uiBehavior: RestfulHandlerUIBehavior?
    private var manager: CommandManager
    
    init() {
        self.manager = CommandManager(type: .NetworkSample)
    }
}


extension MainPageViewModel: RestfulHandler {
    
    func startTest(completion: ((_ user: User?)->Void)?) {
        self.uiBehavior?.showLoading(true)
        self.manager.getUsers { [weak self] user in
            self?.uiBehavior?.showLoading(false)
            self?.uiBehavior?.updateView(user: user)
            completion?(user)
        }
    }
}
