//
//  TagListViewModelTests.swift
//  TagsTests
//
//  Created by Surendra on 17/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import XCTest
@testable import Tags

class TagListViewModelTests: XCTestCase {
    
    var viewModel: TagListViewModelProtocol?
    
    func testGetTags() {
        viewModel = TagListViewModel(withTagService: TronaldDumpTagServiceProviderMock(withfetchTagServiceError: nil, fetchTagInfoServiceError: nil))
        let expectation = self.expectation(description: UUID().uuidString)
        viewModel?.getTags()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(viewModel?.tags.count == 3, "There must be 3 tags")
    }
    
    func testGetTagsWithException() {
        viewModel = TagListViewModel(withTagService: TronaldDumpTagServiceProviderMock(withfetchTagServiceError: NSError(domain: "Domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Found error to fetch tags"]), fetchTagInfoServiceError: nil))

        let expectation = self.expectation(description: UUID().uuidString)
        var onErrorHandlingClosureCalled = false
        var apiError: Error?
        viewModel?.onErrorHandling = { error in
            onErrorHandlingClosureCalled = true
            apiError = error
        }
        viewModel?.getTags()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(onErrorHandlingClosureCalled == true, "onErrorHandling Closure must be called")
        XCTAssertNotNil(apiError, "There must be error")
    }
    
    func testGetTweets() {
        var tweets: [TweetInformation]?
        viewModel = TagListViewModel(withTagService: TronaldDumpTagServiceProviderMock(withfetchTagServiceError: nil, fetchTagInfoServiceError: nil))
        let expectation = self.expectation(description: UUID().uuidString)
        var receivedTweetsClosureCalled = false
        viewModel?.receivedTweets = { tweetList, tag in
            tweets = tweetList
            receivedTweetsClosureCalled = true
        }
        viewModel?.getTweets(forTag: "tag")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(tweets?.count == 1, "There must be one tweet")
        XCTAssert(receivedTweetsClosureCalled == true, "receivedTweets must be called")

    }
    
    func testGetTweetsWithException() {
        
        viewModel = TagListViewModel(withTagService: TronaldDumpTagServiceProviderMock(withfetchTagServiceError: nil, fetchTagInfoServiceError: NSError(domain: "Domain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Found error to fetch tweets"])))

        let expectation = self.expectation(description: UUID().uuidString)
        var onErrorHandlingClosureCalled = false
        var apiError: Error?
        viewModel?.onErrorHandling = { error in
            onErrorHandlingClosureCalled = true
            apiError = error
        }
        viewModel?.getTweets(forTag: "tag")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssert(onErrorHandlingClosureCalled == true, "onErrorHandling Closure must be called")
        XCTAssertNotNil(apiError, "There must be error")

    }
}
