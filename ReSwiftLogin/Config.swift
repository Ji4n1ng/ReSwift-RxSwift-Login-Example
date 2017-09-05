//
//  Config.swift
//  ReSwiftLogin
//
//  Created by 王嘉宁 on 2017/9/3.
//  Copyright © 2017年 jianing. All rights reserved.
//

import UIKit
import ReSwiftRouter

struct Config {
    
    struct Test {
        static let phone = "17865169805"
        static let password = "123456"
    }
    
    struct Color {
        static let orangeDefault = UIColor.init(red: 255 / 255, green: 59 / 255, blue: 48 / 255, alpha: 1)
        static let orangeLight = UIColor.init(red: 255 / 255, green: 233 / 255, blue: 232 / 255, alpha: 1)
    }
    
    struct Route {
        static let login: RouteElementIdentifier = "Login"
        static let main: RouteElementIdentifier = "Main"
    }
    
    struct Identifier {
        static let loginViewController = "LoginViewController"
        static let mainViewController = "MainViewController"
    }
    
    struct Storyboard {
        static let main = UIStoryboard(name: "Main", bundle: nil)
    }
    
}
