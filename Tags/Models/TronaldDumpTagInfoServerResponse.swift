//
//  TronaldDumpTagInfoServerResponse.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct TronaldDumpTagInfoServerResponse {
    enum RootKeys: String, CodingKey {
        case rootEmbedded = "_embedded"
    }
    
    enum EmbeddedKeys: String, CodingKey {
        case tags
    }
    
    let tweetInfoList: [TweetInformation]
}

extension TronaldDumpTagInfoServerResponse: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let rootTagsContainer = try container.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: .rootEmbedded)
        tweetInfoList = try rootTagsContainer.decode([TweetInformation].self, forKey: .tags)
    }
}
