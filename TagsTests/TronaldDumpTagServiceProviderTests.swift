//
//  TronaldDumpTagServiceProviderTests.swift
//  TagsTests
//
//  Created by Surendra on 21/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import XCTest
@testable import Tags

class TronaldDumpTagServiceProviderTests: XCTestCase {
    var tagService: TagServiceProviding?
    
    func testFetchTags() {
        tagService = TronaldDumpTagServiceProvider(withHttpClient: HttpClient(session: .shared), tagsEndPoint: AppConstant.baseEndPoint, tweetsEndPoint: AppConstant.baseEndPoint)
        
        let expectation = self.expectation(description: UUID().uuidString)
        var tags: [String]?
        var apiError: Error?
        tagService?.fetchTags(withComplitionHandler: { (result) in
            switch result {
            case .success(let tagList):
                tags = tagList
            case .failure(let error):
                apiError = error
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(tags != nil, "There must be tag")
        XCTAssertNil(apiError, "API should not return any error")
    }
    
    func testFetchTagsWithURLException() {
        tagService = TronaldDumpTagServiceProvider(withHttpClient: HttpClient(session: .shared), tagsEndPoint: "", tweetsEndPoint: AppConstant.baseEndPoint)
        
        let expectation = self.expectation(description: UUID().uuidString)
        var tags: [String]?
        var apiError: Error?
        tagService?.fetchTags(withComplitionHandler: { (result) in
            switch result {
            case .success(let tagList):
                tags = tagList
            case .failure(let error):
                apiError = error
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(tags, "tags must be nil")
        XCTAssertNotNil(apiError, "There must be apiError")
        XCTAssert(apiError?.localizedDescription == "URL error!", "must be url error")
    }
    
    func testFetchTweets() {
        tagService = TronaldDumpTagServiceProvider(withHttpClient: HttpClient(session: .shared), tagsEndPoint: AppConstant.baseEndPoint, tweetsEndPoint: AppConstant.baseEndPoint)
        
        let expectation = self.expectation(description: UUID().uuidString)
        var tweets: [TweetInformation]?
        var apiError: Error?
        tagService?.fetchTweets(forTag: "Hillary Clinton", complitionHandler: { (result) in
            switch result {
            case .success(let tweetList):
                tweets = tweetList
            case .failure(let error):
                apiError = error
            }
            expectation.fulfill()
        })
        
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(tweets != nil, "There must be tag")
        XCTAssertNil(apiError, "API should not return any error")
    }
    
    
    func testFetchTweetsWithURLException() {
        
        tagService = TronaldDumpTagServiceProvider(withHttpClient: HttpClient(session: .shared), tagsEndPoint: AppConstant.baseEndPoint, tweetsEndPoint: "")
        
        let expectation = self.expectation(description: UUID().uuidString)
        var tweets: [TweetInformation]?
        var apiError: Error?
        tagService?.fetchTweets(forTag: "Hillary Clinton", complitionHandler: { (result) in
            switch result {
            case .success(let tweetList):
                tweets = tweetList
            case .failure(let error):
                apiError = error
            }
            expectation.fulfill()
        })
        
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(tweets, "tweets must be nil")
        XCTAssertNotNil(apiError, "There must be apiError")
        XCTAssert(apiError?.localizedDescription == "URL error!", "must be url error")
    }
}
