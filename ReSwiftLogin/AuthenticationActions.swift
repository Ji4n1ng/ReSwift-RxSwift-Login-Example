//
//  AuthenticationActions.swift
//  ReSwiftLogin
//
//  Created by 王嘉宁 on 2017/9/2.
//  Copyright © 2017年 jianing. All rights reserved.
//

import RxSwift
import ReSwift
import ReSwiftRouter

let globalDisposeBag = DisposeBag()

func authenticateUser (state: State, store: Store<State>) -> Action? {
    
    let service = AuthenticationService()
    
    service.login(phone: state.authenticationState.phoneInput, password: state.authenticationState.passwordInput)
        .subscribe(onNext: { loggedInState in
            afterDelay(1) {
                store.dispatch(UpdateLoggedInState(loggedInState: loggedInState))
                if case .loggedIn = loggedInState {
                    store.dispatch(ReSwiftRouter.SetRouteAction([Config.Route.main]))
                }
            }
        }, onDisposed: {
            log("AuthenticationService Disposed")
        })
        .disposed(by: globalDisposeBag)
    
    return UpdateLoggedInState(loggedInState: .loggingIn)
}


struct UpdateLoggedInState: Action {
    let loggedInState: LoggedInState
}

struct InputLoginInfo: Action {
    let phoneInput: String
    let passwordInput: String
}

