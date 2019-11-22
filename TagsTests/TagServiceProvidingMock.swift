//
//  TagServiceProvidingMock.swift
//  TagsTests
//
//  Created by Surendra on 17/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
@testable import Tags

class TronaldDumpTagServiceProviderMock: TagServiceProviding {
    
    let fetchTagServiceError: Error?
    let fetchTagInfoServiceError: Error?
    
    init(withfetchTagServiceError tagServiceError: Error?, fetchTagInfoServiceError tagInfoError: Error?) {
        self.fetchTagServiceError = tagServiceError
        self.fetchTagInfoServiceError = tagInfoError
    }
    
    func fetchTags(withComplitionHandler completion: @escaping (Result<[String], Error>) -> ()) {
        guard fetchTagServiceError == nil else {
            completion(.failure(fetchTagServiceError!))
            return
        }
        completion(.success(["Tag1", "Tag2", "Tag3"]))
        
    }
    
    func fetchTweets(forTag tag: String, complitionHandler completion: @escaping (Result<[TweetInformation], Error>) -> ()) {
        guard fetchTagInfoServiceError == nil else {
            completion(.failure(fetchTagInfoServiceError!))
            return
        }
        completion(.success([TweetInformation(appearedAt: "appearedAt", createdAt: "appearedAt", quoteId: "quoteId", tweet: "tweet")]))
    }
    
}
