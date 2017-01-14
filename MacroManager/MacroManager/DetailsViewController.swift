//
//  DetailsViewController.swift
//  MacroManager
//
//  Created by Capstone Crew on 10/31/16.
//  Copyright © 2016 Capstone Crew. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{


    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var heightField: UITextField!
    var feetPickerData: [String] = [String]()
    var inchesPickerData: [String] = [String]()
    var heightPickerView = UIPickerView()
    var frontString = ""
    var backString = ""
    var fromName = String() // set by regView
    var fromEmail = String() // set by regView
    var fromPassword = String() // set by regView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Backround color
        self.view.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        
        heightPickerView.dataSource = self
        heightPickerView.delegate = self
        feetPickerData = ["1", "2", "3", "4", "5", "6", "7"]
         inchesPickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        //CONFIGURE TEXT BOXES - SCB
        ageField.attributedPlaceholder = NSAttributedString(string:"AGE",
                                                             attributes:[NSForegroundColorAttributeName: UIColor.white])
        ageField.borderStyle = .none
        ageField.textColor = UIColor.white
        ageField.tag = 0
        ageField.delegate = self
        ageField.returnKeyType = .next
        ageField.keyboardType = .numberPad
        ageField.autocapitalizationType = .words
        ageField.autocorrectionType = .no
        ageField.tintColor = UIColor.white
        
        weightField.attributedPlaceholder = NSAttributedString(string:"WEIGHT",
                                                              attributes:[NSForegroundColorAttributeName: UIColor.white])
        weightField.borderStyle = .none
        weightField.textColor = UIColor.white
        weightField.tag = 1
        weightField.delegate = self
        weightField.returnKeyType = .next
        weightField.keyboardType = .numberPad
        weightField.autocapitalizationType = .none
        weightField.autocorrectionType = .no
        weightField.tintColor = UIColor.white
        
        heightField.attributedPlaceholder = NSAttributedString(string:"HEIGHT",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white])
        heightField.borderStyle = .none
        heightField.textColor = UIColor.white
        heightField.tag = 2
        heightField.delegate = self
        heightField.returnKeyType = .continue
        heightField.keyboardType = .default
        heightField.autocapitalizationType = .none
        heightField.tintColor = UIColor.white
        heightField.inputView = heightPickerView
        //GESTURE RECOGNIZER TO HIDE KEYBOARD - SCB
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        
        //CONFIGURE NEXT BUTTON - SCB
        nextButton.backgroundColor = UIColor.white
        nextButton.layer.cornerRadius = 20
    }
    func hideKeyboard()
    {
        view.endEditing(true)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag = textField.tag + 1;
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if (nextResponder != nil && textField.text != ""){
            
            nextResponder?.becomeFirstResponder()
        }
        else
        {
            //CLEAR KEYBOARD AND TRY LOGIN - AJE
            textField.resignFirstResponder()
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       if (component == 0)
       {
        return feetPickerData.count
        }
       else{
        return inchesPickerData.count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0)
        {
            return feetPickerData[row]
        }
        else{
            return inchesPickerData[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0)
        {
            frontString = feetPickerData[row]
             heightField.text = frontString + "' " + backString + "\""
        }
        else{
            backString = inchesPickerData[row]
             heightField.text = frontString + "' " + backString + "\""        }
    }
    
    
    
    
    @IBAction func unwindFromGoalSlider(segue:UIStoryboardSegue) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
