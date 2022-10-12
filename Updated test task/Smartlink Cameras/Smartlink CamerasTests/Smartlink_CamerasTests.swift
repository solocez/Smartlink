//
//  Smartlink_CamerasTests.swift
//  Smartlink CamerasTests
//
//  Created by SecureNet Mobile Team on 1/10/20.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import XCTest
import RxSwift

@testable import Smartlink_Cameras

class Smartlink_CamerasTests: XCTestCase {

    let bag = DisposeBag()

    @Inject var api: RestAPI

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUsersEndpointReachable() throws {
        let touchEndpointExp = expectation(description: "touch endpoint")
        api.execute(RestRequest(path: "", method: .post, parameters: .body(["method": "getPartnerEnvironment", "username": "helixdemo", "environment": "PRODUCTION"])))
            .subscribe(onSuccess: { _ in
                touchEndpointExp.fulfill()
            }, onError: { error in
                XCTFail("Failed: \(error.localizedDescription)")
            })
            .disposed(by: bag)
            
        wait(for: [touchEndpointExp], timeout: 2)
    }

//    func testParseResponse() throws {
//        let touchEndpointExp = expectation(description: "touch endpoint")
//        api.execute(RestRequest(path: "comments/1", method: .get))
//            .subscribe(onSuccess: { jsonData in
//                XCTAssertNotNil(CommentFactory().dematerialiseComment(from: jsonData))
//                touchEndpointExp.fulfill()
//            }, onFailure: { error in
//                XCTFail("Failed: \(error.localizedDescription)")
//            })
//            .disposed(by: bag)
//
//        wait(for: [touchEndpointExp], timeout: 2)
//    }
}
