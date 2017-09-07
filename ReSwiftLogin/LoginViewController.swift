//
//  LoginViewController.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/2.
//  Copyright © 2017年 jianing. All rights reserved.
//

import UIKit
import ReSwift
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, StoreSubscriber {
    
    // MARK: Properties

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var fastInputButton: UIButton!
    
    var bottomConstraint: NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) { state in
            state.select { $0.authenticationState }
        }
        
        NotificationCenter.default.addObserver(self, selector: .keyboardWillShow, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: .keyboardWillHide, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: Config
    
    func configBinding() {
        
        loginButton.rx.tap
            .subscribe(onNext: {
                store.dispatch(authenticateUser)
            })
            .disposed(by: disposeBag)
        
        let phoneValue = Variable("")
        let passwordValue = Variable("")
        
        (phoneTextField.rx.text.orEmpty <-> phoneValue)
            .addDisposableTo(disposeBag)
        (passwordTextField.rx.text.orEmpty <-> passwordValue)
            .addDisposableTo(disposeBag)
        
        let _ = Observable.combineLatest(phoneValue.asObservable(), passwordValue.asObservable())
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {
                store.dispatch(
                    InputLoginInfo(
                        phoneInput: $0,
                        passwordInput: $1
                    )
                )
            })
            .disposed(by: disposeBag)
        
        fastInputButton.rx.tap
            .subscribe(onNext: {
                stringToObservable(Config.Test.phone, interval: 0.1)
                    .scan("") { $0 + $1 }
                    .subscribe(onNext: {
                        phoneValue.value = $0
                    })
                    .disposed(by: self.disposeBag)
                stringToObservable(Config.Test.password, interval: 0.1)
                    .scan("") { $0 + $1 }
                    .subscribe(onNext: {
                        passwordValue.value = $0
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
    }
    
    
    // MARK: State Updates
    
    func newState(state: AuthenticationState) {
        
        switch state.loggedInState {
        case let .loginFailed(error):
            self.clearAllNotice()
            log("loginFailed", .fuck)
            log(error, .error)
        case .loggingIn:
            log("loggingIn")
            self.pleaseWait()
        case let .loggedIn(token):
            log("loggedIn", .happy)
            log("get token: " + token)
            self.clearAllNotice()
        default:
            break
        }
        
        phoneTextField.backgroundColor = state.phoneTextFieldBackground
        passwordTextField.backgroundColor = state.passwordTextFieldBackground
        loginButton.isEnabled = state.loginButtonEnabled
        
    }
    
}

// MARK: To prevent keyboard occlusion

fileprivate extension Selector {
    static let keyboardWillShow = #selector(LoginViewController.keyboardWillShow)
    static let keyboardWillHide = #selector(LoginViewController.keyboardWillHide)
}

extension LoginViewController: UITextFieldDelegate {
    
    // MARK: TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        [phoneTextField, passwordTextField].forEach {
            $0.resignFirstResponder()
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo as NSDictionary! else { return }
        guard let keyboardHeight = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        UIView.animate(withDuration: duration.doubleValue) {
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve.intValue)!)
            self.updateViewConstraintsForKeyboardHeight(keyboardHeight)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo as NSDictionary! else { return }
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        UIView.animate(withDuration: duration.doubleValue) {
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve.intValue)!)
            self.updateViewConstraintsForKeyboardHeight(0)
        }
        
    }
    
    func updateViewConstraintsForKeyboardHeight(_ keyboardHeight: CGFloat) {
        
        if bottomConstraint != nil {
            self.view.removeConstraints([bottomConstraint!])
            bottomConstraint = nil
        }
        
        if keyboardHeight != 0 {
            bottomConstraint = NSLayoutConstraint(item: self.view,
                                                  attribute: NSLayoutAttribute.bottom,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: self.loginButton,
                                                  attribute: NSLayoutAttribute.bottom,
                                                  multiplier: 1.0,
                                                  constant: keyboardHeight)
            self.view.addConstraints([bottomConstraint!])
        }
        self.view.layoutIfNeeded()
    }
    
}
