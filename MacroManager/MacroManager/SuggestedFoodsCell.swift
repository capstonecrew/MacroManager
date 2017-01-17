//
//  SuggestedFoodsCell.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 1/12/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class SuggestedFoodsCell: UITableViewCell {

    @IBOutlet weak var foodsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.foodsCollectionView!.register(UINib(nibName: "FoodCollectionCell", bundle: nil), forCellWithReuseIdentifier: "foodCollectionCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
