//
//  ProfileViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/16/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//  Alex Schultz - 1/18/17

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var userBirthField: UITextField!
    @IBOutlet weak var userGoalLabel: UILabel!
    @IBOutlet weak var userWeightField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Coolvetica", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = "Profile"
        // FILLER TEXT TO BE CHANGED
        userNameField.text = "Aaron Edwards"
        userBirthField.text = "24 years old"
        userWeightField.text = "150 pounds"
        
    }

    @IBAction func changeGoalButton(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
