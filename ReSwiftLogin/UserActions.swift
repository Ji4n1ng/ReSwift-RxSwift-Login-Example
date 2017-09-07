//
//  UserAction.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/4.
//  Copyright © 2017年 jianing. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func getUserInfo (state: State, store: Store<State>) -> Action? {
    
    guard let token = state.authenticationState.loggedInState.token else { return nil }
    
    let service = UserService()
    
    service.getInfo(token: token)
        .subscribe(onNext: { userInfo in
            afterDelay(1) {
                store.dispatch(UpdateUserInfo(info: userInfo))
            }
        }, onDisposed: {
            log("UserService Disposed")
        })
        .disposed(by: globalDisposeBag)
    
    return nil
}

struct UpdateUserInfo: Action {
    let info: UserInfoState
}

struct Quit: Action { }
