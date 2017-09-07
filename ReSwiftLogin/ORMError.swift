//
//  ORMError.swift
//  WeekUp
//
//  Created by JianingWang on 13/08/2017.
//  Copyright © 2017 Mazeal. All rights reserved.
//

import Foundation

enum ORMError: Error {
    
    case ORMNoRepresentor
    
    case ORMNotSuccessfulHTTP
    
    case ORMNoData
    
    case ORMCouldNotMakeObjectError
    
    case ORMParseJSONError
    
    case ORMBizError(resultCode: String?, resultMsg: String?)
    
}

enum BizStatus: Int {
    
    case BizSuccess = 0
    
    case BizError
}


