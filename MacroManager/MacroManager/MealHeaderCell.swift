//
//  MealHeaderCell.swift
//  MacroManager
//
//  Created by spencer on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

protocol mealHeaderCellDelegate {
    func dismiss(sender: MealHeaderCell)
    func addFavorite(sender:MealHeaderCell)
    
}

class MealHeaderCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var proteinsAmount: UILabel!
    @IBOutlet weak var carbsAmount: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var fatsAmount: UILabel!
    weak var parentVC: MealView2Controller! // BAD CODE
    var delegate: mealHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addButton.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        addButton.backgroundColor = UIColor.clear
        addButton.layer.borderWidth = 2.0
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.cornerRadius = 5.0
        
        
        
        // Initialization code
    }

    @IBAction func favoriteButtonClick(_ sender: Any) {
        
     self.delegate?.addFavorite(sender: self)
        
        
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addMealAct(_ sender: Any) {
        
        // ADD MEAL AND RETURN TO PREV VIEW CONTROLLER
        print("adding meal")
        
        
        currentUser.addMealToLog(mealEaten: parentVC.recievedNix!)
        delegate?.dismiss(sender: self) // POP DOWN
    }
    
}
