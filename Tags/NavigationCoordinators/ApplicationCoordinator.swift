//
//  ApplicationCoordinator.swift
//  Tags
//
//  Created by Surendra on 21/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let router: Router
    let tagListCoordinator: TagListCoordinator
    
    init(withWindow window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        router = TagRouter(navigationController: rootViewController)
        tagListCoordinator = TagListCoordinator(withPresenter: router)
    }
    
    func start() {
        window.rootViewController = router.navigationController
        tagListCoordinator.start()
        window.makeKeyAndVisible()
    }
    
}
