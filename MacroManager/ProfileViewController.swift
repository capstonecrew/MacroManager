//
//  ProfileViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/16/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//  Alex Schultz - 1/18/17

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
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
        
        userNameField.delegate = self
        userNameField.text = currentUser.name!
        userBirthField.delegate = self
        userBirthField.text = "\(currentUser.age!) years old"
        userWeightField.delegate = self
        userWeightField.text = "\(currentUser.weight!) pounds"
        
        // hide keyboard upon tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func hideKeyboard(){
        
        view.endEditing(true)
    }

    @IBAction func changeGoalButton(_ sender: Any) {
        
    }
    
    
    
    @IBAction func doneEditingName(_ sender: Any) {
        guard let x = userNameField.text, x != ""  else {
            userNameField.text = currentUser.name!
            return
        }
        currentUser.name = userNameField.text!
        userNameField.text = currentUser.name!
    }
    
    @IBAction func doneEditingAge(_ sender: Any) {
        guard let x = userBirthField.text, x != "" else {
            userBirthField.text = "\(currentUser.age!) years old"
            return
        }
        currentUser.age = Int(userBirthField.text!)
        userBirthField.text = "\(currentUser.age!) years old"
    }
    @IBAction func doneEditingWeight(_ sender: Any) {
        guard let x = userWeightField.text, x != "" else {
            userWeightField.text = "\(currentUser.weight!) pounds"
            return
        }
        currentUser.weight = Int(userWeightField.text!)
        userWeightField.text = "\(currentUser.weight!) pounds"
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
