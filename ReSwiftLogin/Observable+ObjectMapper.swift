//
//  Observable+ObjectMapper.swift
//  WeekUp
//
//  Created by 王嘉宁 on 13/08/2017.
//  Copyright © 2017 Mazeal. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya
import SwiftyJSON
import Result

extension Observable {
    
    /// handle the network response and map to JSON
    /// - returns: Observable<JSON>
    func handleResponseMapJSON() -> Observable<Result<JSON, ORMError>> {
        
        return self.map { representor in
            
            guard let response = representor as? Moya.Response else {
                return .failure(ORMError.ORMNoRepresentor)
            }
            
            guard ((200...299) ~= response.statusCode) else {
                return .failure(ORMError.ORMNotSuccessfulHTTP)
            }
            
            guard let json = JSON.init(rawValue: response.data),
                json != JSON.null,
                let code = json["code"].int else {
                    return .failure(ORMError.ORMParseJSONError)
            }
            
            guard code == BizStatus.BizSuccess.rawValue else {
                let message: String = {
                    let json = JSON.init(data: response.data)
                    guard let msg = json["status"].string else { return "" }
                    return msg
                }()
                log(message, .error)
                return .failure(ORMError.ORMBizError(resultCode: "\(code)", resultMsg: message))
            }
            
            return .success(json["result"])
            
        }
    }
    
    /// JSON map to object
    /// - returns: Observable<T>
    func jsonMapObject<T: Mappable>(type: T.Type) -> Observable<Result<T, ORMError>> {
        
        return self.map { rawResult in
            
            guard let result = rawResult as? Result<JSON, ORMError> else {
                return .failure(ORMError.ORMParseJSONError)
            }
            
            switch result {
            case let .success(json):
                
                guard json != JSON.null,
                    let dict = json.dictionaryObject else {
                        return .failure(ORMError.ORMParseJSONError)
                }
                
                guard let object = Mapper<T>().map(JSON: dict) else {
                    return .failure(ORMError.ORMCouldNotMakeObjectError)
                }
                
                return .success(object)
                
            case let .failure(error):
                return .failure(error)
            }
            
        }
    }
    
    /// JSON map to object array
    /// - returns: Observable<[T]>
    func jsonMapArray<T: Mappable>(type: T.Type) -> Observable<Result<[T], ORMError>> {
        
        return self.map { rawResult in
            
            guard let result = rawResult as? Result<JSON, ORMError> else {
                return .failure(ORMError.ORMParseJSONError)
            }
            
            switch result {
            case let .success(json):
                
                guard json != JSON.null,
                    let jsonArray = json.array else {
                        return .failure(ORMError.ORMParseJSONError)
                }
                
                let dictArray = jsonArray.map { $0.dictionaryObject! }
                
                return .success(Mapper<T>().mapArray(JSONArray: dictArray))
                
            case let .failure(error):
                return .failure(error)
            }
            
        }
    }
    
}
