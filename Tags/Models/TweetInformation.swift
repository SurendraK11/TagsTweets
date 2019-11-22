//
//  TweetInformation.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct TweetInformation: Decodable {
    let appearedAt: String
    let createdAt: String
    let quoteId: String
    let tweet: String
    
    enum CodingKeys: String, CodingKey {
        case appearedAt = "appeared_at"
        case createdAt = "created_at"
        case quoteId = "quote_id"
        case tweet = "value"
    }
}
