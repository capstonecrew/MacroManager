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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Coolvetica", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = "Profile"
        userNameField.text = "Aaron Edwards" // FILLER TEXT FOR NOW TO BE REMOVED
        userBirthField.text = "11/23/1992"
    }

    @IBAction func changeGoalButton(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
