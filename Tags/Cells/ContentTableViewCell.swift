//
//  ContentTableViewCell.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    
    enum Constants {
        static let reuseIdentifier = "ContentTableViewCell"
    }
}
