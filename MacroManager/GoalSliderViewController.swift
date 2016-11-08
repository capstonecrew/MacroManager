//
//  GoalSliderViewController.swift
//  MacroManager
//
//  Created by Capstone Crew on 10/31/16.
//  Copyright © 2016 Capstone Crew. All rights reserved.
//

import UIKit

class GoalSliderViewController: UIViewController {

    @IBOutlet weak var goalSlider: UISlider!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalSlider.minimumValue = 0
        goalSlider.maximumValue = 90
        
        goalSlider.tintColor = UIColor.lightGray
        goalSlider.thumbTintColor = UIColor(red:0.17, green:0.57, blue:0.56, alpha:1.0)
        
        signUpButton.backgroundColor = UIColor.white
        signUpButton.layer.cornerRadius = 5
    
        // Do any additional setup after loading the view.
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
        
        
        if(goalSlider.value >= 0 && goalSlider.value < 30){
            
            goalLabel.text = "LOSE WEIGHT"
            
        }else if (goalSlider.value >= 30 && goalSlider.value < 60){
            
            goalLabel.text = "MAINTAIN WEIGHT"
        
        }else{
        
            goalLabel.text = "GAIN WEIGHT"
        }
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
