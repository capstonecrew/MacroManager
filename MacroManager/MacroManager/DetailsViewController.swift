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
    @IBOutlet weak var genderField: UITextField!
    
    var feetPickerData: [String] = [String]()
    var inchesPickerData: [String] = [String]()
    var genderPickerData: [String] = [String]()
    var heightPickerView = UIPickerView()
    var genderPickerView = UIPickerView()
    var frontString = ""
    var backString = ""
    var fromName: String! // set by regView
    var fromEmail: String! // set by regView
    var fromPassword: String! // set by regView
    var genderString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 1)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //Background color
        self.view.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        genderPickerView.dataSource = self
        genderPickerView.delegate = self
        heightPickerView.dataSource = self
        heightPickerView.delegate = self
        heightPickerView.backgroundColor = .white
        heightPickerView.tag = 1
        genderPickerView.tag = 2
        genderPickerData = ["Male", "Female"]
        feetPickerData = ["1", "2", "3", "4", "5", "6", "7"]
        inchesPickerData = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
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
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = .lightGray
        toolBar.tintColor = .white
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.hideKeyboard))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.hideKeyboard))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        heightField.inputAccessoryView = toolBar
        genderField.inputAccessoryView = toolBar
        genderField.attributedPlaceholder = NSAttributedString(string:"GENDER",
                                                            attributes:[NSForegroundColorAttributeName: UIColor.white])
        genderField.borderStyle = .none
        genderField.textColor = UIColor.white
        genderField.tag = 4
        genderField.delegate = self
        genderField.returnKeyType = .next
        genderField.keyboardType = .default
        genderField.autocapitalizationType = .none
        genderField.autocorrectionType = .no
        genderField.tintColor = UIColor.white
        genderField.inputView = genderPickerView
        
        //GESTURE RECOGNIZER TO HIDE KEYBOARD - SCB
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        
        //CONFIGURE NEXT BUTTON - SCB
        nextButton.backgroundColor = UIColor.white
        nextButton.layer.cornerRadius = 20
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    func hideKeyboard(){
        
        view.endEditing(true)
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//        
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0{
//                self.view.frame.origin.y += keyboardSize.height
//            }
//        }
//    }
    
    
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
        
        switch pickerView.tag{
        case 1: return 2
        case 2: return 1
        default: break
        }
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      
        switch pickerView.tag{
        
        case 1:   if (component == 0)
                {
                        return feetPickerData.count
                }
                  else {
                        return inchesPickerData.count
                        }
        case 2:
        return genderPickerData.count
        default: return 0
            }
        

    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        switch pickerView.tag{
            case 1:
        if (component == 0)
        {
            return feetPickerData[row]
        }
        else {
            return inchesPickerData[row]
        }
        case 2:
            return genderPickerData[row]
        default: return "hello"
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        
        switch pickerView.tag {
        case 1:
        if (component == 0)
        {
            frontString = feetPickerData[row]
             heightField.text = frontString + "' " + backString + "\""
        }
        else {
            backString = inchesPickerData[row]
             heightField.text = frontString + "' " + backString + "\""        }
        
            
        case 2:
            genderString = genderPickerData[row]
            genderField.text = genderString
        default: break
            
        }
        
        
    }
    
   
   
    @IBAction func secretButton1(_ sender: Any) {
        genderField.text = "Apache Helicopter"
        apacheButton.isHidden = false
    }
    @IBOutlet weak var apacheButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toActivityView" {
            print("sending 3 fields to regView")
            if let nextView: ActivityLevelViewController = segue.destination as? ActivityLevelViewController {
                
                nextView.fromName = self.fromName
                nextView.fromEmail = self.fromEmail
                nextView.fromPassword = self.fromPassword
                if(self.heightField.text!.isEmpty)
                {
                    nextView.fromHeight = "5' 6\""
                }
                else {
                nextView.fromHeight = self.heightField.text!
                }
                if(self.weightField.text!.isEmpty)
                {
                    nextView.fromWeight = "150"
                }
                else{
                    nextView.fromWeight = self.weightField.text!
                }
                if(self.genderField.text!.isEmpty)
                {
                    nextView.fromGender = "Male"
                }
                else{
                   nextView.fromGender = self.genderField.text!
                }
                if(self.ageField.text!.isEmpty)
                {
                    nextView.fromAge = "25"
                    
                }
                else{
                nextView.fromAge = self.ageField.text!
                }
                
            }
        }
    }

}
