//
//  State.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/2.
//  Copyright © 2017年 jianing. All rights reserved.
//

import ReSwift
import ReSwiftRouter
import Result

struct State: StateType, HasNavigationState {
    var navigationState: NavigationState
    var authenticationState: AuthenticationState
    var userState: UserState
}
