//
//  TagListViewControllerDependencyContainer.swift
//  Tags
//
//  Created by Surendra on 21/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

/// TagListViewControllerDependencyResolver helps  to proivde TagListViewModelProtocol, this
/// encapsulates creation of view model
protocol TagListViewControllerDependencyResolver {
    var viewModel: TagListViewModelProtocol {get}
}

class TagListViewControllerDependencyContainer: TagListViewControllerDependencyResolver {
    var viewModel: TagListViewModelProtocol {
        get {
            return TagListViewModel(withTagService: TronaldDumpTagServiceProvider(withHttpClient: HttpClient(session: .shared), tagsEndPoint: AppConstant.baseEndPoint, tweetsEndPoint: AppConstant.baseEndPoint))
        }
    }
}
