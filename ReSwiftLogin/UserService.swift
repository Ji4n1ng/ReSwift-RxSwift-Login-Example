//
//  UserService.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/4.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class UserService {
    
    private let provider = RxMoyaProvider<UserAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getInfo(token: String) -> Observable<UserInfoState> {
        return provider.request(.getInfo(token))
            .handleResponseMapJSON()
            .jsonMapObject(type: UserInfoModel.self)
            .map { result in
                switch result {
                case let .success(userInfo):
                    return .success(userInfo)
                case let .failure(error):
                    return .failure(error)
                }
            }
    }
    
}
