//
//  MealHeaderCell.swift
//  MacroManager
//
//  Created by spencer on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class MealHeaderCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var proteinsAmount: UILabel!
    @IBOutlet weak var sugarsAmount: UILabel!
    @IBOutlet weak var fatsAmount: UILabel!
    weak var parentVC: MealView2Controller!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addMealAct(_ sender: Any) {
        
        // ADD MEAL AND RETURN TO PREV VIEW CONTROLLER
        
    }
    
}
