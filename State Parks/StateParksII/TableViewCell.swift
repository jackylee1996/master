//
//  TableViewCell.swift
//  State Parks
//
//  Created by Jackeline Lee on 10/1/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var parkTitle: UILabel!
    @IBOutlet weak var parkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
