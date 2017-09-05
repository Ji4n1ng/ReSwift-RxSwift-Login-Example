//
//  AccountAPI.swift
//  WeekUp
//
//  Created by 王嘉宁 on 14/08/2017.
//  Copyright © 2017 Mazeal. All rights reserved.
//

import Foundation
import Moya

public enum AuthenticationAPI {
    case login(String, String)
}

extension AuthenticationAPI: TargetType {
    
    public var baseURL: URL { return URL(string: "http://139.199.38.207:8000")! }
    
    public var path: String {
        switch self {
        case .login:
            return "/auth"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .login(username, password):
            return ["username": username, "password": password]
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
