//
//  MainViewController.swift
//  ReSwiftLogin
//
//  Created by JianingWang on 2017/9/3.
//  Copyright © 2017年 jianing. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
import RxSwift
import RxCocoa

class MainViewController: UIViewController, StoreSubscriber {

    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var backToLoginButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) { state in
            state.select { $0.userState }
        }
        
        store.dispatch(getUserInfo)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    
    // MARK: Config
    
    func configBinding() {
        
        backToLoginButton.rx.tap
            .subscribe(onNext: {
                store.dispatch(Quit())
                store.dispatch(SetRouteAction([Config.Route.login]))
            })
            .disposed(by: disposeBag)
        
    }
    
    
    // MARK: State Updates
    
    func newState(state: UserState) {
        
        switch state.userInfoState {
        case let .success(userInfo):
            log(userInfo)
            self.nameLabel.text = userInfo.name
            self.phoneLabel.text = userInfo.phone
        case let .failure(error):
            log(error, .error)
        default:
            break
        }
        
    }
    
}
