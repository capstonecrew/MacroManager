//
//  CustomMealDetailCellTableViewCell.swift
//  MacroManager
//
//  Created by Alex Schultz on 2/23/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class CustomMealDetailCellTableViewCell: UITableViewCell {
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
