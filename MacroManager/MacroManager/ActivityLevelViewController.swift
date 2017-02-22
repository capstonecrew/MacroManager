//
//  ActivityLevelViewController.swift
//  MacroManager
//
//  Created by Gregg Hovsepian on 2/21/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ActivityLevelViewController: UIViewController {
    
    @IBOutlet weak var littletonone: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var moderate: UIButton!
    @IBOutlet weak var light: UIButton!

    @IBOutlet weak var heavy: UIButton!
    @IBOutlet weak var veryheavy: UIButton!
    var previousBtn: UIButton!
    
    var fromName: String! // set by regView
    var fromEmail: String! // set by regView
    var fromPassword: String! // set by regView
    var fromWeight: String!
    var fromHeight: String!
    var fromAge: String!
    var fromGender: String!
    var selectedOption: Int!
    
    let options = ["Little to None", "Light", "Moderate", "Heavy", "Very Heavy"]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Backround color
        self.view.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        
       
        littletonone.backgroundColor = .white
        littletonone.layer.cornerRadius = 20
        littletonone?.titleLabel?.textColor = .lightGray
        littletonone.tag = 0
        
        light.backgroundColor = .white
        light.layer.cornerRadius = 20
        light?.titleLabel?.textColor = .lightGray
        light.tag = 1
        
        moderate.backgroundColor = .white
        moderate.layer.cornerRadius = 20
        moderate?.titleLabel?.textColor = .lightGray
        moderate.tag = 2
        
        heavy.backgroundColor = .white
        heavy.layer.cornerRadius = 20
        heavy?.titleLabel?.textColor = .lightGray
        heavy.tag = 3
        
        veryheavy.backgroundColor = .white
        veryheavy.layer.cornerRadius = 20
        veryheavy?.titleLabel?.textColor = .lightGray
        veryheavy.tag = 4
        
        nextButton.backgroundColor = UIColor.white
        nextButton.layer.cornerRadius = 20
         
        littletonone.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        light.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        moderate.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        heavy.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        veryheavy.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
 
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
        
        selectedOption = selectedBtn.tag
        
        previousBtn = selectedBtn
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGoalView" {
            print("sending 3 fields to regView")
            if let nextView: GoalSliderViewController = segue.destination as? GoalSliderViewController {
                
                nextView.fromName = self.fromName
                nextView.fromEmail = self.fromEmail
                nextView.fromPassword = self.fromPassword
                nextView.fromHeight = self.fromWeight
                nextView.fromWeight = self.fromWeight
                nextView.fromGender = self.fromGender
                nextView.fromAge = self.fromAge
                nextView.fromActivity = options[self.selectedOption]
                
            }
        }
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
