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
        
        let proteinRect = CGRect(x: 0, y: 0, width: proteinProgressWidth, height: 21)
        let proteinPath = UIBezierPath(roundedRect: proteinRect, cornerRadius: 10)
        let carbsRect = CGRect(x: 0, y: 0, width: carbsProgressWidth, height: 21)
        let carbsPath = UIBezierPath(roundedRect: carbsRect, cornerRadius: 10)
        let fatsRect = CGRect(x: 0, y: 0, width: fatsProgressWidth, height: 21)
        let fatsPath = UIBezierPath(roundedRect: fatsRect, cornerRadius: 10)
        
        let proteinProgress = CAShapeLayer()
        proteinProgress.fillColor = UIColor.blue.cgColor
        proteinProgress.path = proteinPath.cgPath
        
        let carbsProgress = CAShapeLayer()
        carbsProgress.fillColor = UIColor.green.cgColor
        carbsProgress.path = carbsPath.cgPath
        
        let fatsProgress = CAShapeLayer()
        fatsProgress.fillColor = UIColor.orange.cgColor
        fatsProgress.path = fatsPath.cgPath
        
        let anim = CABasicAnimation(keyPath: "fillColor")
        anim.fromValue = UIColor.clear.cgColor
        anim.toValue = UIColor.blue.cgColor
        anim.duration = 2
        proteinProgress.add(anim, forKey: "anim")
        
        let anim2 = CABasicAnimation(keyPath: "fillColor")
        anim2.fromValue = UIColor.clear.cgColor
        anim2.toValue = UIColor.green.cgColor
        anim2.duration = 2
        carbsProgress.add(anim2, forKey: "anim")
        
        let anim3 = CABasicAnimation(keyPath: "fillColor")
        anim3.fromValue = UIColor.clear.cgColor
        anim3.toValue = UIColor.orange.cgColor
        anim3.duration = 2
        fatsProgress.add(anim3, forKey: "anim")
        
        
        proteinProgressBack.layer.addSublayer(proteinProgress)
        carbsProgressBack.layer.addSublayer(carbsProgress)
        fatsProgressBack.layer.addSublayer(fatsProgress)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
