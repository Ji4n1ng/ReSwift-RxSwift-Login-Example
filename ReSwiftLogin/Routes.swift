//
//  Routes.swift
//  ReSwiftLogin
//
//  Created by 王嘉宁 on 2017/9/3.
//  Copyright © 2017年 jianing. All rights reserved.
//

import ReSwiftRouter


class RootRoutable: Routable {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setToLoginViewController() -> Routable {
        self.window.rootViewController = Config.Storyboard.main.instantiateViewController(withIdentifier: Config.Identifier.loginViewController)
        
        return LoginViewRoutable(self.window.rootViewController!)
    }
    
    func setToMainViewController() -> Routable {
        self.window.rootViewController = Config.Storyboard.main.instantiateViewController(withIdentifier: Config.Identifier.mainViewController)
        
        return MainViewRoutable(self.window.rootViewController!)
    }
    
    func changeRouteSegment(
        _ from: RouteElementIdentifier,
        to: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) -> Routable
    {
        
        if to == Config.Route.login {
            completionHandler()
            log("changeRouteSegment loginRoute")
            return self.setToLoginViewController()
        } else if to == Config.Route.main {
            completionHandler()
            log("changeRouteSegment mainViewRoute")
            return self.setToMainViewController()
        } else {
            fatalError("Route not supported!")
        }
    }
    
    func pushRouteSegment(
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) -> Routable
    {
        
        if routeElementIdentifier == Config.Route.login {
            completionHandler()
            log("pushRouteSegment loginRoute")
            return self.setToLoginViewController()
        } else if routeElementIdentifier == Config.Route.main {
            completionHandler()
            log("pushRouteSegment mainViewRoute")
            return self.setToMainViewController()
        } else {
            fatalError("Route not supported!")
        }
    }
    
    func popRouteSegment(
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler)
    {
        // TODO: this should technically never be called -> bug in router
        completionHandler()
    }
    
}
