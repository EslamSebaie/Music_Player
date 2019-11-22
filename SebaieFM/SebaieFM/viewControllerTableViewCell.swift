//
//  viewControllerTableViewCell.swift
//  SebaieFM
//
//  Created by Eslam Sebaie on 11/5/19.
//  Copyright © 2019 Eslam Sebaie. All rights reserved.
//

import UIKit

class viewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var laImage: UIImageView!
   
    @IBOutlet weak var laLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
