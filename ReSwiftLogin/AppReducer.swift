//
//  AppReducer.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/2.
//  Copyright © 2017年 jianing. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: State?) -> State {
    return State(
        navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
        authenticationState: authenticationReducer(state: state?.authenticationState, action: action),
        userState: userReducer(state: state?.userState, action: action)
    )
}
