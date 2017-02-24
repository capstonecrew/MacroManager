//
//  ProfileViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/16/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//  Alex Schultz - 1/18/17

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var userBirthField: UITextField!
    @IBOutlet weak var userGoalLabel: UILabel!
    @IBOutlet weak var userWeightField: UITextField!
   var editable = false
     let options : [String] = ["Little to None", "Light", "Moderate", "Heavy", "Very Heavy"]
     let goalOptions : [String] = ["Lose Fat", "Maintain", "Gain Muscle"]
    @IBOutlet weak var goalPicker: UIPickerView!
    
    @IBOutlet weak var activityPicker: UIPickerView!
    var newGoalString = ""
    var newActivityString = ""
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
        goalPicker.delegate = self
        activityPicker.delegate = self
        goalPicker.selectedRow(inComponent: getRow(string: currentUser.goal))
        activityPicker.selectedRow(inComponent: getRow(string: currentUser.activityLevel))
        
        // hide keyboard upon tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        userNameField.isUserInteractionEnabled = false
        userBirthField.isUserInteractionEnabled = false
        userWeightField.isUserInteractionEnabled = false
        goalPicker.isUserInteractionEnabled = false
        goalPicker.isUserInteractionEnabled = false
        
    }
    
    func hideKeyboard(){
        
        view.endEditing(true)
    }

    @IBAction func changeGoalButton(_ sender: Any) {
        
    }
    func getRow(string:String)->Int{
      var row = 0
        
        for index in 0...2{
            if (currentUser.activityLevel == goalOptions[index])
            {
                return index
            }
            
        }
        for otherIndex in 0...4{
            if(currentUser.goal == options[otherIndex])
            {
                return otherIndex
            }
        }
      
        return row
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
    
    @IBAction func editPush(_ sender: Any) {
        if(!editable)
        {
            editButton.setTitle("Save", for: .normal)
            userNameField.isUserInteractionEnabled = true
            userBirthField.isUserInteractionEnabled = true
            userWeightField.isUserInteractionEnabled = true
            goalPicker.isUserInteractionEnabled = true
            activityPicker.isUserInteractionEnabled = true
            
            editable = true
            currentUser.client.updatePoints(d: "update")
        }
        else{
            
            editButton.setTitle("Edit", for: .normal)
            userNameField.isUserInteractionEnabled = false
            userBirthField.isUserInteractionEnabled = false
            userWeightField.isUserInteractionEnabled = false
            goalPicker.isUserInteractionEnabled = false
            activityPicker.isUserInteractionEnabled = false
            editable = false
            var newAgeString = userBirthField.text
            var separateAge: [String] = newAgeString!.components(separatedBy: " ")
            var newAge = separateAge[0]
            currentUser.age = Int(newAge)
            newAgeString = userWeightField.text
            separateAge = newAgeString!.components(separatedBy: " ")
            newAge = separateAge[0]
            currentUser.weight = Int(newAge)
            
            currentUser.name = userNameField.text
            currentUser.goal = newGoalString
            currentUser.activityLevel = newActivityString
           
            
            
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0)
        {
            return goalOptions.count
        }
        else{
            
            return options.count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0)
        {
            return goalOptions[row]
        }
        else{
            
            return options[row]
        }
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0)
        {
            newGoalString = goalOptions[row]
            
        }
        else{
           newActivityString = options[row]
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
