//
//  AuthenticationReducer.swift
//  ReSwiftLogin
//
//  Created by 王嘉宁 on 2017/9/2.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import ReSwift

func authenticationReducer(state: AuthenticationState?, action: Action) -> AuthenticationState {
    
    var state = state ?? AuthenticationState()
    
    switch action {
    case _ as ReSwiftInit:
        break
    case let action as UpdateLoggedInState:
        state.loggedInState = action.loggedInState
    case let action as InputLoginInfo:
        let phoneValid = isValidPhone(action.phoneInput)
        let passwordValid = isValidPassword(action.passwordInput)
        let bothValid = phoneValid && passwordValid
        let phoneBackColor: UIColor = phoneValid ? .clear : Config.Color.orangeLight
        let passwordBackColor: UIColor = passwordValid ? .clear : Config.Color.orangeLight
        state.phoneInput = action.phoneInput
        state.passwordInput = action.passwordInput
        state.phoneTextFieldBackground = phoneBackColor
        state.passwordTextFieldBackground = passwordBackColor
        state.loginButtonEnabled = bothValid
    case _ as Quit:
        state = AuthenticationState()
    default:
        break
    }
    
    return state
}


