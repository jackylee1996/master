//
//  BuildingTableViewCell.swift
//  Campus Walk
//
//  Created by Jackeline Lee on 10/15/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class BuildingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buildingCell: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
