//
//  TweetListViewController.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

final class TweetListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let tweetInfoList: [TweetInformation]
    let tagTitle: String
    
    init(withTagInfoList list: [TweetInformation], tag: String) {
        tweetInfoList = list
        tagTitle = tag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = tagTitle
        let contentTableViewCellNib: UINib = UINib(nibName: ContentTableViewCell.Constants.reuseIdentifier, bundle: nil)
        tableView.register(contentTableViewCellNib, forCellReuseIdentifier: ContentTableViewCell.Constants.reuseIdentifier)
    }

}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension TweetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.Constants.reuseIdentifier, for: indexPath) as? ContentTableViewCell else {
            fatalError()
        }
        cell.content.text = tweetInfoList[indexPath.row].tweet
        cell.selectionStyle = .none
        return cell
    }

}
