//
//  FoodCollectionCell.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 1/12/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

protocol FoodCollectionCellDelegate {
    func tapped(sender: FoodCollectionCell)
}

class FoodCollectionCell: UICollectionViewCell {

    var delegate: FoodCollectionCellDelegate?
    @IBOutlet weak var foodBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func cellTapped(_ sender: Any) {
       
        self.delegate?.tapped(sender: self)
    }
    
    
}
