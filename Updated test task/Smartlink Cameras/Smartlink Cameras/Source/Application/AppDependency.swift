//
//  AppDependency.swift
//  Smartlink Cameras
//
//  Created by SecureNet Mobile Team on 1/10/20.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import Foundation

protocol HasAPIService {
    var apiService: APIServiceProtocol { get }
}

protocol HasUserService {
    var userService: UserServiceProtocol { get }
}

protocol HasRestAPI {
    var restApi: RestAPIProtocol { get }
}

struct AppDependency: HasAPIService, HasUserService, HasRestAPI {
    
    let apiService: APIServiceProtocol
    let userService: UserServiceProtocol
    let restApi: RestAPIProtocol
    
    init() {
        apiService = APIService()
        userService = UserService(apiService: apiService)
        restApi = RestManager()
    }
    
}
