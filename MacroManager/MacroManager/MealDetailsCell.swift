//
//  MealDetailsCell.swift
//  MacroManager
//
//  Created by Aaron Edwards on 1/27/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class MealDetailsCell: UITableViewCell {

    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var accessoryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
