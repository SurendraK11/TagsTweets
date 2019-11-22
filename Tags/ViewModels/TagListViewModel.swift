//
//  TagListViewModel.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

protocol TagListViewModelProtocol {
    var tags: [String] {get}
    func getTags()
    func getTweets(forTag tag: String)
    
    var onErrorHandling: ((Error) -> ())? {get set}
    var receivedTags: (() -> ())? {get set}
    var receivedTweets: (([TweetInformation], String) -> ())? {get set}
}

class TagListViewModel: TagListViewModelProtocol {
    
    var receivedTweets: (([TweetInformation], String) -> ())?
    var receivedTags: (() -> ())?
    var onErrorHandling: ((Error) -> Void)?
    
    let tagService: TagServiceProviding
    
    var tags: [String] = [] {
        didSet  {
            receivedTags?()
        }
    }
    
    init(withTagService service: TagServiceProviding) {
        self.tagService = service
    }
    
    func getTags() {
        tagService.fetchTags { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let tags):
                    self.tags = tags
                case .failure(let error):
                    self.onErrorHandling?(error)
                }
            }
        }
    }
    
    func getTweets(forTag tag: String) {
        tagService.fetchTweets(forTag: tag) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self.receivedTweets?(list, tag)
                case .failure(let error):
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
