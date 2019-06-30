//
//  NameImageCell.swift
//  Knitting Yarn Calc
//
//  Created by Deborah Engelmeyer on 6/9/19.
//  Copyright © 2019 The Inquisitive Introvert. All rights reserved.
//

import UIKit

class NameImageCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var projectImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
