//
//  MealHeaderCell.swift
//  MacroManager
//
//  Created by spencer on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

protocol mealHeaderCellDelegate {
    func addFavorite(sender: MealHeaderCell)
    func removeFavorite(sender: MealHeaderCell)
}

class MealHeaderCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var proteinsAmount: UILabel!
    @IBOutlet weak var carbsAmount: UILabel!
    @IBOutlet weak var fatsAmount: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    
    weak var parentVC: MealView2Controller! // BAD CODE
    var delegate: mealHeaderCellDelegate?
    var isFavorite: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favoriteButtonClick(_ sender: Any) {
    
        if !isFavorite{
            self.delegate?.addFavorite(sender: self)
            self.favoriteBtn.setImage(UIImage(named: "favoriteFilled"), for: .normal)
            isFavorite = true
            currentUser.client.updatePoints(d: "addFav")
        }else{
            self.delegate?.removeFavorite(sender: self)
            self.favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
            isFavorite = false
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
