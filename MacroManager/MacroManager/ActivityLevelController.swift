//
//  ActivityLevelController.swift
//  MacroManager
//
//  Created by Gregg Hovsepian on 2/20/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ActivityLevelController: UIViewController {
    
    @IBOutlet weak var littletonone: UIButton!
    @IBOutlet weak var light: UIButton!
    @IBOutlet weak var moderate: UIButton!
    @IBOutlet weak var heavy: UIButton!
    @IBOutlet weak var veryheavy: UIButton!
    
    var previousBtn: UIButton!

    @IBOutlet weak var nextbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Backround color
        self.view.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        
        
      
        littletonone.backgroundColor = .white
        littletonone.layer.cornerRadius = 20
        littletonone?.titleLabel?.textColor = .lightGray
        
        light.backgroundColor = .white
        light.layer.cornerRadius = 20
        light?.titleLabel?.textColor = .lightGray
        
        moderate.backgroundColor = .white
        moderate.layer.cornerRadius = 20
        moderate?.titleLabel?.textColor = .lightGray
        
        heavy.backgroundColor = .white
        heavy.layer.cornerRadius = 20
        heavy?.titleLabel?.textColor = .lightGray
        
        veryheavy.backgroundColor = .white
        veryheavy.layer.cornerRadius = 20
        veryheavy?.titleLabel?.textColor = .lightGray
        
        littletonone.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        light.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        moderate.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        heavy.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        veryheavy.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        
        nextbutton.backgroundColor = UIColor.white
        nextbutton.layer.cornerRadius = 20
 
        // Do any additional setup after loading the view.
    }
    
 
    func selected(sender: UIButton){
        
        if(previousBtn != nil){
            previousBtn!.backgroundColor = .white
            previousBtn!.tintColor = .lightGray
        }
        
        let selectedBtn = sender as UIButton
        selectedBtn.backgroundColor = .darkGray
        selectedBtn.tintColor = .white
        
        previousBtn = selectedBtn
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hi gregg write code here
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
