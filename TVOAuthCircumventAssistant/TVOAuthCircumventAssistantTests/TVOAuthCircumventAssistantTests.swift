//
//  TVOAuthCircumventAssistantTests.swift
//  TVOAuthCircumventAssistantTests
//
//  Created by Garrett Richards on 1/2/16.
//  Copyright © 2016 Garrett Richards. All rights reserved.
//

import XCTest
import Alamofire
import OHHTTPStubs
@testable import TVOAuthCircumventAssistant

class TVOAuthCircumventAssistantTests: XCTestCase {

    var config = TVOAuthCircumventAssistantConfiguration()
    var assistant = TVOAuthCircumventAssistant()
    let testDomain = "httpbin.org"

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    func testRetrieveAuthenticationInfoURL() {
        //  Given
        let expectedAccessToken = "nnnjasldfjaslfj;alsdjfl;asdjf;lsdfjs;ldfjasldfjsdlfjsld;fj"
        let key = "accessToken"
        config.retrieveAuthenticationInfoURL = "https://\(testDomain)/response-headers?\(key)=\(expectedAccessToken)"
        assistant.configuration = config
        let expectation = expectationWithDescription("message")

        //  Stub
        mockResponse([key:expectedAccessToken])
        
        //  When
        assistant.retrieveAuthenticationInfoURL {
            (response, error) -> Void in
            XCTAssertEqual(response?[key] as? String, expectedAccessToken)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testfetchTVToken() {
        //  Given
        let expectedToken = "123456"
        let key = "tvToken"
        config.tvTokenFetchURL = "https://\(testDomain)/response-headers?\(key)=\(expectedToken)"
        assistant.configuration = config
        let expectation = expectationWithDescription("message")

        //  Stub
        mockResponse([key:expectedToken])

        //  When
        assistant.fetchTVToken {
            (response, error) -> Void in
            XCTAssertEqual(response?[key] as? String, expectedToken, "got response: \(response)")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    func testFetchTVTokenWithInvalidURL() {
        //  Given
        let expectedError = NSError(domain: TVOAuthCircumventAssistantDomain, code: 100, userInfo: nil)
        let expectation = expectationWithDescription("message")

        //  When
        assistant.fetchTVToken {
            (response, error) -> Void in
            XCTAssertNotNil(error)
            if let e = error as? NSError {
                XCTAssertEqual(e, expectedError)
            } else {
                XCTFail("incorrect error returned")
            }
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.5, handler: nil)
    }

    func testRetrieveAuthenticationInfoURLWithInvalidURL() {
        //  Given
        let expectedError = NSError(domain: TVOAuthCircumventAssistantDomain, code: 100, userInfo: nil)
        let expectation = expectationWithDescription("message")

        //  When
        assistant.retrieveAuthenticationInfoURL {
            (response, error) -> Void in
            XCTAssertNotNil(error)
            if let e = error as? NSError {
                XCTAssertEqual(e, expectedError)
            } else {
                XCTFail("incorrect error returned")
            }
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(0.5, handler: nil)
    }

    //  MARK: - Helpers

    private func mockResponse(payload: [String:AnyObject]) {
        OHHTTPStubs.stubRequestsPassingTest({ $0.URL!.host == self.testDomain }, withStubResponse: { (request: NSURLRequest) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(JSONObject: payload, statusCode: 200, headers: nil)
        })
    }
}
