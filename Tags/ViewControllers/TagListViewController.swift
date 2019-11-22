//
//  TagListViewController.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

protocol TagListViewControllerDelegate: class {
    func showTweets(_ tweets: [TweetInformation], forSelectedTag tag: String)
}


final class TagListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: TagListViewControllerDelegate?

    private var viewModel: TagListViewModelProtocol
    init(withDependencyResolver dependencyResolver: TagListViewControllerDependencyResolver) {
        self.viewModel = dependencyResolver.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tags"
        let contentTableViewCellNib: UINib = UINib(nibName: ContentTableViewCell.Constants.reuseIdentifier, bundle: nil)
        tableView.register(contentTableViewCellNib, forCellReuseIdentifier: ContentTableViewCell.Constants.reuseIdentifier)
        
        //setup properties of view model
        setupViewModel()
        
        //get tags
        activityIndicator.startAnimating()
        viewModel.getTags()
    }
    
    //MARK: private funtion
    private func setupViewModel() {
        
        viewModel.onErrorHandling = { [unowned self] error in
            self.activityIndicator.stopAnimating()
            //show error
            self.showError(error.localizedDescription)
            //allow user again for further selection
            self.tableView.allowsSelection = true
        }
        
        viewModel.receivedTags = { [unowned self] in
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
        
        viewModel.receivedTweets = { [unowned self] tweets, tag in
            self.activityIndicator.stopAnimating()
            self.tableView.allowsSelection = true
            self.delegate?.showTweets(tweets, forSelectedTag: tag)
        }
    }
    
    //MARK: - Private function
    private func showError(_ error: String) {
        activityIndicator.stopAnimating()
        let alertViewController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        navigationController?.present(alertViewController, animated: true, completion: nil)
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension TagListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tags.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.Constants.reuseIdentifier, for: indexPath) as? ContentTableViewCell else {
            fatalError()
        }
        cell.content.text = viewModel.tags[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicator.startAnimating()
        tableView.allowsSelection = false
        viewModel.getTweets(forTag: self.viewModel.tags[indexPath.row])
    }
}
