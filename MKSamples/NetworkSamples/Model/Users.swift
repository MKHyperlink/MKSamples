//
//  Users.swift
//  MKSamples
//
//  Created by Mike on 2018/9/17.
//  Copyright © 2018 Mike. All rights reserved.
//

import Foundation

/*
 {
 "id": 1,
 "name": "Leanne Graham",
 "username": "Bret",
 "email": "Sincere@april.biz",
 "address": {
     "street": "Kulas Light",
     "suite": "Apt. 556",
     "city": "Gwenborough",
     "zipcode": "92998-3874",
     "geo": {
     "lat": "-37.3159",
     "lng": "81.1496"
    }
 },
 "phone": "1-770-736-8031 x56442",
 "website": "hildegard.org",
 "company": {
     "name": "Romaguera-Crona",
     "catchPhrase": "Multi-layered client-server neural-net",
     "bs": "harness real-time e-markets"
     }
 }
 */

public struct User: Codable {
    
    struct Address: Codable {
        
        struct Geo: Codable {
            var lat: String
            var lng: String
        }
        
        var street: String
        var suite: String
        var city: String
        var zipcode: String
        var geo: Geo
    }
    
    struct Company: Codable {
        
        var name: String
        var catchPhrase: String
        var bs: String
    }
    
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    
}


