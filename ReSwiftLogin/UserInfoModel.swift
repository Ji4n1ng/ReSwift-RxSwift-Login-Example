//
//  Task.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/2.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserInfoModel: Mappable{
    
    var avatar : String?
    var email : String?
    var id : Int?
    var name : String?
    var phone: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        avatar <- map["photo_url"]
        email <- map["email"]
        id <- map["id"]
        name <- map["realname"]
        phone <- map["username"]
    }
    
}
