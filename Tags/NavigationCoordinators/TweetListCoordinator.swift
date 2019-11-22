//
//  TweetListCoordinator.swift
//  Tags
//
//  Created by Surendra on 21/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

class TweetListCoordinator: Coordinator {
    private let presenter: Router
    private let tweets: [TweetInformation]
    private let tag: String
    
    private var tweetListViewController: TweetListViewController?

    init(withPresenter presenter: Router, tweets: [TweetInformation], tag: String) {
        self.presenter = presenter
        self.tweets = tweets
        self.tag = tag
    }
    
    func start() {
        let tweetListViewController = TweetListViewController(withTagInfoList: tweets, tag: tag)
        presenter.push(tweetListViewController, animated: true, completion: nil)
        self.tweetListViewController = tweetListViewController
    }
    
}
