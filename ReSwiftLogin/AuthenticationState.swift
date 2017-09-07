//
//  AuthenticationState.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/2.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

typealias Token = String

enum LoggedInState {
    
    case notLoggedIn
    case loggingIn
    case loginFailed(ORMError)
    case loggedIn(Token)
    
    var isLoggedIn: Bool {
        switch self {
        case .loggedIn: return true
        default: return false
        }
    }
    
    var token: Token? {
        switch self {
        case let .loggedIn(token): return token
        default: return nil
        }
    }
    
}

struct AuthenticationState: StateType {
    
    var loggedInState: LoggedInState
    var phoneInput: String
    var passwordInput: String
    var phoneTextFieldBackground: UIColor
    var passwordTextFieldBackground: UIColor
    var loginButtonEnabled: Bool
    
    init(loggedInState: LoggedInState = .notLoggedIn,
         phoneInput: String = "",
         passwordInput: String = "",
         phoneTextFieldBackground: UIColor = .clear,
         passwordTextFieldBackground: UIColor = .clear,
         loginButtonEnabled: Bool = false) {
        self.loggedInState = loggedInState
        self.phoneInput = phoneInput
        self.passwordInput = passwordInput
        self.phoneTextFieldBackground = phoneTextFieldBackground
        self.passwordTextFieldBackground = passwordTextFieldBackground
        self.loginButtonEnabled = loginButtonEnabled
    }
}


