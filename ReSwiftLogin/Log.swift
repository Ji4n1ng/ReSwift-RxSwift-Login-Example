//
//  Log.swift
//  WeekUp
//
//  Created by 王嘉宁 on 13/08/2017.
//  Copyright © 2017 Mazeal. All rights reserved.
//

import Foundation

enum LogType: String {
    case ln = "✏️"
    case error = "❗️"
    case date = "🕒"
    case url = "🌏"
    case json = "💡"
    case fuck = "🖕"
    case happy = "😄"
}

func log<T>(_ message: T,
            _ type: LogType = .ln,
            file: String = #file,
            method: String = #function,
            line: Int    = #line) {
    #if DEBUG
        print("\(type.rawValue) \((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
