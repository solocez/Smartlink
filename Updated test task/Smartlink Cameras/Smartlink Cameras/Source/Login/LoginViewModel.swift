//
//  LoginViewModel.swift
//  Smartlink Cameras
//
//  Created by SecureNet Mobile Team on 1/10/20.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import Foundation
import RxSwift

final class LoginViewModel: ViewModelProtocol {
    
    typealias Dependency = HasUserService & HasRestAPI
    
    struct Bindings {
        let loginButtonTap: Observable<Void>
        let loginNameChanged: Observable<String?>
    }
    
    let loginResult: Observable<Void>
    
    fileprivate let bag = DisposeBag()
    
    init(dependency: Dependency, bindings: Bindings) {
        loginResult = bindings.loginButtonTap
            .do(onNext: { _ in dependency.userService.login()  })
        
        bindings.loginNameChanged
                .flatMap { dependency.restApi
                        .execute(RestRequestBuilder(username: $0 ?? "").default)
                        .catchErrorJustReturn(Data())
                        .map { LoginResponseFactory().dematerialiseLoginResponse(from: $0) }
                }
                .filter { $0 != nil }
                .subscribe(onNext: { loginResponseEntry in
                    NSLog(loginResponseEntry?.platform.baseURL?.absoluteString ?? "")
                }, onError: { error in
                    NSLog("ERROR WHILE TRIGGERING REQUEST: \(error)")
                })
                .disposed(by: bag)
    }
    
    deinit {
    }
}
