//
//  TagListCoordinator.swift
//  Tags
//
//  Created by Surendra on 21/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

class TagListCoordinator: Coordinator {
    private let presenter: Router
    private var tagListViewController: TagListViewController?
    
    init(withPresenter presenter: Router) {
        self.presenter = presenter
    }
    
    func start() {
        let tagListViewController = TagListViewController(withDependencyResolver: TagListViewControllerDependencyContainer())
        tagListViewController.delegate = self
        presenter.push(tagListViewController, animated: true, completion: nil)
        self.tagListViewController = tagListViewController
    }
    
}

extension TagListCoordinator: TagListViewControllerDelegate {
    func showTweets(_ tweets: [TweetInformation], forSelectedTag tag: String) {
        let tweetListCoordinator = TweetListCoordinator(withPresenter: presenter, tweets: tweets, tag: tag)
        tweetListCoordinator.start()
    }
}
