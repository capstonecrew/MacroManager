//
//  SearchTableViewCell.swift
//  MacroManager
//
//  Created by Alex Schultz on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var qualityIcon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.itemImage.layer.cornerRadius = self.itemImage.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Custom functions for qualityLabel
    func setQualityBad(){
    
        qualityIcon.setImage(UIImage(named: "bad_Icon"), for: .normal)
    }
    
    func setQualityOkay(){
        
        qualityIcon.setImage(UIImage(named: "ok_Icon"), for: .normal)
    }
    
    func setQualityGood(){
        
        qualityIcon.setImage(UIImage(named: "good_Icon"), for: .normal)
        
    }

}
