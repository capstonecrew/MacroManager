//
//  SuggestedFoodsCell.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 1/12/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

protocol SuggestedFoodsCellDelegate {
    func toSearch()
}

class SuggestedFoodsCell: UITableViewCell {

    @IBOutlet weak var foodsCollectionView: UICollectionView!
    @IBOutlet weak var addFavoriteBtn: UIButton!
    
    var delegate: SuggestedFoodsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.addFavoriteBtn.layer.cornerRadius = 10
        self.addFavoriteBtn.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func addFavoriteBtnPressed(_ sender: Any) {
    
        self.delegate?.toSearch()
    }
    
}
