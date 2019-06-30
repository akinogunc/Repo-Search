//
//  ContributorCell.swift
//  Repo Search
//
//  Created by AKIN on 30.06.2019.
//  Copyright © 2019 AKIN. All rights reserved.
//

import UIKit

class ContributorCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var iv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iv.layer.cornerRadius = iv.frame.width/2.0
        iv.clipsToBounds = true
    }

    func setImage(url : String){
        ImageCache.getImage(url: url, completion: { (image) in
            self.iv.image = image
        })
    }

}
