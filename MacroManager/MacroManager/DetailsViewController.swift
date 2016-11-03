//
//  DetailsViewController.swift
//  MacroManager
//
//  Created by spencer on 11/2/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var feetPickerView: UIPickerView!
    @IBOutlet weak var inchesPickerView: UIPickerView!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    var feetPickerData: [String] = [String]()
    var inchesPickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
        heightField.isSecureTextEntry = true
        heightField.keyboardType = .default
        heightField.autocapitalizationType = .none
        heightField.tintColor = UIColor.white
        
        //GESTURE RECOGNIZER TO HIDE KEYBOARD - SCB
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        
        //CONFIGURE LOGIN BUTTON - SCB
      //  nextButton.backgroundColor = UIColor.white
      //  nextButton.layer.cornerRadius = 5
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
