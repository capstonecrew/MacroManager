//
//  DailyGoalProgressCell.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit

class DailyGoalProgressCell: UITableViewCell {

    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var proteinProgress: UIProgressView!
    @IBOutlet weak var carbsProgress: UIProgressView!
    @IBOutlet weak var fatsProgress: UIProgressView!
    
    @IBOutlet weak var proteinRatioLbl: UILabel!
    @IBOutlet weak var carbsRatioLbl: UILabel!
    @IBOutlet weak var fatsRatioLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupProgressBars()
    }
    
    func setupProgressBars(){

        proteinProgress.layer.cornerRadius = 10
        carbsProgress.layer.cornerRadius = 10
        fatsProgress.layer.cornerRadius = 10
        
        proteinProgress.clipsToBounds = true
        carbsProgress.clipsToBounds = true
        fatsProgress.clipsToBounds = true
        
        proteinProgress.tintColor = UIColor(red:0.45, green:0.87, blue:0.60, alpha:1.0)
        carbsProgress.tintColor = UIColor(red:0.45, green:0.87, blue:0.60, alpha:1.0)
        fatsProgress.tintColor = UIColor(red:0.45, green:0.87, blue:0.60, alpha:1.0)
        
        proteinProgress.trackTintColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
        carbsProgress.trackTintColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
        fatsProgress.trackTintColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
