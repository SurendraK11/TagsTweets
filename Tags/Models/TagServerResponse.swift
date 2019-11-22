//
//  TagServerResponse.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

struct TronaldDumpTagsServerResponse: Decodable {
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case tags = "_embedded"
    }
}
