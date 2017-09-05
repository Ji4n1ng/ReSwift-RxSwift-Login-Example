//
//  AuthenticationService.swift
//  ReSwiftLogin
//
//  Created by 王嘉宁 on 2017/9/3.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class AuthenticationService {
    
    private let provider = RxMoyaProvider<AuthenticationAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func login(phone: String, password: String) -> Observable<LoggedInState> {
        return provider.request(.login(phone, password))
            .handleResponseMapJSON()
            .map { result in
                switch result {
                case let .success(json):
                    guard let token = json.string else {
                        log("No Token", .error)
                        return .loginFailed(ORMError.ORMNoData)
                    }
                    return .loggedIn(token)
                case let .failure(error):
                    return .loginFailed(error)
                }
            }
    }
    
}
