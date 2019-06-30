//
//  RepositoryCell.swift
//  Repo Search
//
//  Created by AKIN on 30.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var RepoName: UILabel!
    @IBOutlet weak var RepoDescription: UILabel!
    @IBOutlet weak var RepoLanguage: UILabel!
    @IBOutlet weak var RepoStars: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


}
