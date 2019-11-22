//
//  AppDelegate.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = ApplicationCoordinator(withWindow: window)
        self.applicationCoordinator = applicationCoordinator
        applicationCoordinator.start()
        
        return true
    }

}

