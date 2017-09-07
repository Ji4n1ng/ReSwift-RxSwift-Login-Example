//
//  UserReducer.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/4.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import ReSwift

func userReducer(state: UserState?, action: Action) -> UserState {
    
    var state = state ?? UserState()
    
    switch action {
    case _ as ReSwiftInit:
        break
    case let action as UpdateUserInfo:
        state.userInfoState = action.info
    case _ as Quit:
        state = UserState()
    default:
        break
    }
    
    return state
}
