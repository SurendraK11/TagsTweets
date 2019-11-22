//
//  TagRouter.swift
//  Tags
//
//  Created by Surendra on 21/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

class TagRouter: Router {
    
    private var completions: [UIViewController : () -> Void]
    
    var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        completions = [:]
    }
    
    func present(_ controller: UIViewController, animated: Bool) {
        navigationController.present(controller, animated: animated, completion: nil)
    }
    
    func push(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        //just to avoid pushing navigation controllers
        guard controller is UINavigationController == false else {
            return
        }
        if let completion = completion {
            completions[controller] = completion
        }
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        completion()
        completions.removeValue(forKey: controller)
    }
}
