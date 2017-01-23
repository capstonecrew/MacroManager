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
        
        userNameField.text = currentUser.name!
        userBirthField.text = "\(currentUser.age!) years old"
        userWeightField.text = "\(currentUser.weight!) pounds"
        
    }

    @IBAction func changeGoalButton(_ sender: Any) {
        
    }
    
    
    // GUARD TO MAKE SURE TEXTFIELDS ARE NOT EMPTY
    
    @IBAction func doneEditingName(_ sender: Any) {
        guard let x = userNameField.text, x != ""  else {
            userNameField.text = currentUser.name!
            return
        }
        currentUser.name = userNameField.text!
        userNameField.text = currentUser.name!

    }
    
    @IBAction func doneEditingAge(_ sender: Any) {
        currentUser.age = Int(userBirthField.text!)
        userBirthField.text = "\(currentUser.age!) years old"
    }
    @IBAction func doneEditingWeight(_ sender: Any) {
        currentUser.weight = Int(userWeightField.text!)
        userWeightField.text = "\(currentUser.weight!) pounds"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
