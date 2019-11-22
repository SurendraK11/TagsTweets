//
//  Router.swift
//  Tags
//
//  Created by Surendra on 21/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    func present(_ controller: UIViewController, animated: Bool)
    func push(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
}

