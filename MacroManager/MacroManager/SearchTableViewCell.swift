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
    @IBOutlet weak var qualityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Custom functions for qualityLabel
    func setQualityBad(){
        qualityLabel.text = "Bad."
        qualityLabel.textColor = UIColor.red
    }
    
    func setQualityOkay(){
        qualityLabel.text = "Okay."
        qualityLabel.textColor = UIColor.yellow
    }
    
    func setQualityGood(){
        qualityLabel.text = "Good!"
        qualityLabel.textColor = UIColor.green
    }

}
