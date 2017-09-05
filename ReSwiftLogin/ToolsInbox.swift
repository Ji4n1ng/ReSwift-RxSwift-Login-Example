//
//  ToolsInbox.swift
//  ReSwiftLogin
//
//  Created by 王嘉宁 on 2017/9/3.
//  Copyright © 2017年 jianing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}


/// Check if the phone number is valid
/// - parameter phone: the string being detected
/// - returns: Bool
func isValidPhone(_ phone: String?) -> Bool {
    
    guard let phone = phone else { return false }
    
    let regEx = "^1(3|4|5|7|8)\\d{9}$"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", regEx)
    
    return emailTest.evaluate(with: phone)
}

/// Check if the password is valid
/// - parameter message: the string being detected
/// - note: validity: length greater than 6 digits
/// - returns: Bool
func isValidPassword(_ password: String?) -> Bool {
    
    guard let password = password else { return false }
    
    guard password.characters.count >= 6 else { return false }
    
    return true
}


infix operator <->

/// Bidirectional binding
/// - note: see [link](https://github.com/ReactiveX/RxSwift/issues/606)
/// - returns: Disposable
func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let bindToUIDisposable = variable.asObservable()
        .bind(to: property)
    let bindToVariable = property
        .subscribe(onNext: { n in
            variable.value = n
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}

/// Send the characters in the string at intervals
/// - parameter text: the string
/// - parameter interval: time interval
/// - returns: Observable<String>
func stringToObservable(_ text: String, interval: TimeInterval) -> Observable<String> {
    return Observable.create { observer in
        
        let count = text.characters.count
        
        let queue = DispatchQueue(label: "com.jianing.ReSwiftLogin.timer", attributes: .concurrent)
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.scheduleRepeating(deadline: DispatchTime.now(), interval: interval)
        
        var index = 0
        timer.setEventHandler {
            guard index < count else {
                timer.cancel()
                observer.onCompleted()
                return
            }
            observer.on(.next(text[index]))
            index += 1
        }
        timer.resume()
        
        return Disposables.create()
    }
}


