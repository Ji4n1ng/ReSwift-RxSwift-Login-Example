//
//  UserState.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/4.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

enum UserInfoState {
    case none
    case success(UserInfoModel)
    case failure(ORMError)
}

struct UserState: StateType {
    
    var userInfoState: UserInfoState
    
    init(userInfoState: UserInfoState = .none) {
        self.userInfoState = userInfoState
    }
}

