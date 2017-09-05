//
//  AppDelegate.swift
//  ReSwiftLogin
//
//  Created by 王嘉宁 on 2017/9/2.
//  Copyright © 2017年 jianing. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

var store = Store<State>(reducer: appReducer, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var router: Router<State>!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()

        let rootRoutable = RootRoutable(window: window!)
        
        router = Router(store: store, rootRoutable: rootRoutable) { state in
            state.select { $0.navigationState }
        }
        
        store.dispatch(ReSwiftRouter.SetRouteAction([Config.Route.login]))
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

