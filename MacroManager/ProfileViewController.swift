//
//  ProfileViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/16/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//  Alex Schultz - 1/18/17

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var userBirthField: UITextField!
    @IBOutlet weak var userGoalLabel: UILabel!
    @IBOutlet weak var userWeightField: UITextField!
    
    var editable = false
    let activityLevels : [String] = ["Little to None", "Light", "Moderate", "Heavy", "Very Heavy"]
    let goalOptions : [String] = ["Lose Fat", "Maintain", "Gain Muscle"]
    var uid: String!
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var activityPicker: UIPickerView!
    
    var newGoalString = currentUser.goal
    var newActivityString = currentUser.activityLevel
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.29, green:0.55, blue:0.90, alpha:1.0)
        navigationController?.navigationBar.isTranslucent = false

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
        goalPicker.selectRow(getGoalRow(currentUser.goal), inComponent: 0, animated: true)
        activityPicker.selectRow(getActivityRow(currentUser.activityLevel), inComponent: 0, animated: true)
        
        // hide keyboard upon tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        userNameField.isUserInteractionEnabled = false
        userBirthField.isUserInteractionEnabled = false
        userWeightField.isUserInteractionEnabled = false
        goalPicker.isUserInteractionEnabled = false
        goalPicker.isUserInteractionEnabled = false
        
        self.editButton.layer.cornerRadius = 10
        self.editButton.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        
    }
    
    func hideKeyboard(){
        
        view.endEditing(true)
    }

    @IBAction func changeGoalButton(_ sender: Any) {
        
    }
    
    func getGoalRow(_ goal: String) -> Int{
        
        var row = 0
        
        for i in 0...goalOptions.count - 1{
            
            if goalOptions[i] == goal{
                
                row = i
            }
        }
        
        return row
        
    }
    
    func getActivityRow(_ activityLevel: String) -> Int{
        
        var row = 0
        
        for i in 0...activityLevels.count - 1{
            
            if activityLevels[i] == activityLevel{
                
                row = i
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
        
        let oldWeight = currentUser.weight
        var newWeight:Int
        
        if(!editable)
        {
            editButton.setTitle("Save", for: .normal)
            userNameField.isUserInteractionEnabled = true
            userBirthField.isUserInteractionEnabled = true
            userWeightField.isUserInteractionEnabled = true
            goalPicker.isUserInteractionEnabled = true
            activityPicker.isUserInteractionEnabled = true
            
            editable = true
            
        }
        else{
            uid = FIRAuth.auth()?.currentUser?.uid
            ref = FIRDatabase.database().reference()
            let userRef = ref.child("users").child(uid!)
            
            
            editButton.setTitle("Edit", for: .normal)
            userNameField.isUserInteractionEnabled = false
            userBirthField.isUserInteractionEnabled = false
            userWeightField.isUserInteractionEnabled = false
            goalPicker.isUserInteractionEnabled = false
            activityPicker.isUserInteractionEnabled = false
            editable = false
            let newAgeString = userBirthField.text
            var separateAge: [String] = newAgeString!.components(separatedBy: " ")
            let newAge = separateAge[0]
            let newWeightString = userWeightField.text
            var separateWeight: [String] = newWeightString!.components(separatedBy: " ")
            let newWeight = separateWeight[0]
            currentUser.age = Int(newAge)
            
        
         
            currentUser.weight = Int(newWeight)
            let updates = ["age": Int(newAge), "weight": Int(newWeight), "name": userNameField.text, "goal":newGoalString, "activityLevel":newActivityString] as [String : Any]
            userRef.updateChildValues(updates)
            
            currentUser.name = userNameField.text
            currentUser.goal = newGoalString
            currentUser.activityLevel = newActivityString
            currentUser.calorieCalc()
            currentUser.macronutrientCalc()
            
            currentUser.client.updatePoints(d: "update")
            
            currentUser.client.updateWeightGoal(oldW: oldWeight!, newW: Int(newWeight)!)
        }
    }
    
    @IBAction func logoutMenuBtnPressed(_ sender: Any) {
    
        let myActionSheet = UIAlertController(title: "", message: "What to do?", preferredStyle: .actionSheet)
       
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive){ (ACTION) in
            do{
                try FIRAuth.auth()?.signOut()
                if let storyboard = self.storyboard {
                    
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
                    self.view.window?.rootViewController = viewController
                    self.view.window?.makeKeyAndVisible()
                }
            }catch{
                print("Error signing out...")
            }
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (ACTION) in
            print("cancel button tapped")
            
        }
        myActionSheet.addAction(logoutAction)
        myActionSheet.addAction(cancelAction)
        
        self.present(myActionSheet, animated: true, completion: nil)
        
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
            
            return activityLevels.count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0)
        {
            return goalOptions[row]
        }
        else{
            
            return activityLevels[row]
        }
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0)
        {
            
            newGoalString = goalOptions[row]
            
        }
        else{
           newActivityString = activityLevels[row]
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
