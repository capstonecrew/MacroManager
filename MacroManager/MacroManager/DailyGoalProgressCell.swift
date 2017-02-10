//
//  DailyGoalProgressCell.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit

class DailyGoalProgressCell: UITableViewCell {

    
    @IBOutlet weak var proteinProgressBack: UIView!
    @IBOutlet weak var carbsProgressBack: UIView!
    @IBOutlet weak var fatsProgressBack: UIView!
    var proteinProgress: CALayer!
    var fatsProgress: CALayer!
    var carbsProgress: CALayer!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupProgressBars()
    }
    
    func setupProgressBars(){
    
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        proteinProgressBack.layer.cornerRadius = 10
        carbsProgressBack.layer.cornerRadius = 10
        fatsProgressBack.layer.cornerRadius = 10
        
        let progressBarMaxWidth = screenWidth - 30
        let proteinProgressWidth = 65/100 * progressBarMaxWidth
        let carbsProgressWidth = 30/100 * progressBarMaxWidth
        let fatsProgressWidth = 85/100 * progressBarMaxWidth
        
        let proteinRect = CGRect(x: 0, y: 0, width: 0, height: 21)
        let carbsRect = CGRect(x: 0, y: 0, width: 0, height: 21)
        let fatsRect = CGRect(x: 0, y: 0, width: 0, height: 21)
        
        proteinProgress = CALayer()
        proteinProgress.backgroundColor = UIColor(red:0.24, green:0.88, blue:0.58, alpha:1.0).cgColor
        proteinProgress.bounds = proteinRect
        proteinProgress.anchorPoint = CGPoint.zero
        proteinProgress.cornerRadius = 10
        
        fatsProgress = CALayer()
        fatsProgress.backgroundColor = UIColor(red:0.24, green:0.88, blue:0.58, alpha:1.0).cgColor
        fatsProgress.bounds = fatsRect
        fatsProgress.anchorPoint = CGPoint.zero
        fatsProgress.cornerRadius = 10
        
        carbsProgress = CALayer()
        carbsProgress.backgroundColor = UIColor(red:0.24, green:0.88, blue:0.58, alpha:1.0).cgColor
        carbsProgress.bounds = carbsRect
        carbsProgress.anchorPoint = CGPoint.zero
        carbsProgress.cornerRadius = 10
        
        //proteinProgress.fillColor = UIColor(red:0.24, green:0.88, blue:0.58, alpha:1.0).cgColor
        //proteinProgress.path = proteinPath.cgPath
        
        
        proteinProgressBack.layer.addSublayer(proteinProgress)
        carbsProgressBack.layer.addSublayer(carbsProgress)
        fatsProgressBack.layer.addSublayer(fatsProgress)
        
//        UIView.animate(withDuration: 2.0, delay: 5.0, options: .curveEaseInOut, animations: {
//            self.proteinProgress.bounds.size = CGSize(width: self.proteinProgress.bounds.size.width + proteinProgressWidth, height: self.proteinProgress.bounds.size.height)
//            self.carbsProgress.bounds.size = CGSize(width: self.carbsProgress.bounds.size.width + carbsProgressWidth, height: self.carbsProgress.bounds.size.height)
//            self.fatsProgress.bounds.size = CGSize(width: self.fatsProgress.bounds.size.width + fatsProgressWidth, height: self.fatsProgress.bounds.size.height)
//        }, completion: {(completed) in
//            print("done")
//        })
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
