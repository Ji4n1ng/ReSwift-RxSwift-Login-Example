//
//  UserAPI.swift
//  ReSwiftLogin
//
//  Created by 王嘉宁 on 2017/9/4.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import Moya

public enum UserAPI {
    case getInfo(String)
}

extension UserAPI: TargetType {
    
    public var baseURL: URL { return URL(string: "http://139.199.38.207:8000")! }
    
    public var path: String {
        switch self {
        case .getInfo:
            return "/user/i"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .getInfo(token):
            return ["api_token": token]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        return .request
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return "{\"data\":{\"id\":\"your_new_gif_id\"},\"meta\":{\"status\":200,\"msg\":\"OK\"}}".data(using: String.Encoding.utf8)!
        }
    }
}
