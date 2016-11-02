//
//  SignInViewController.swift
//  MacroManager
//
//  Created by Capstone Crew on 10/31/16.
//  Copyright © 2016 Capstone Crew. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SETS STATUS BAR TO WHITE - AJE
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        //CONFIGURE TEXT BOXES - AJE
        emailField.attributedPlaceholder = NSAttributedString(string:"EMAIL",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white])
        emailField.borderStyle = .none
        emailField.textColor = UIColor.white
        emailField.tag = 0
        emailField.delegate = self
        emailField.returnKeyType = .next
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.tintColor = UIColor.white
        
        passwordField.attributedPlaceholder = NSAttributedString(string:"PASSWORD",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white])
        passwordField.borderStyle = .none
        passwordField.textColor = UIColor.white
        passwordField.tag = 1
        passwordField.delegate = self
        passwordField.returnKeyType = .done
        passwordField.isSecureTextEntry = true
        passwordField.keyboardType = .default
        passwordField.autocapitalizationType = .none
        passwordField.tintColor = UIColor.white
        
        //GESTURE RECOGNIZER TO HIDE KEYBOARD - AJE
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.hideKeyboard))
        view.addGestureRecognizer(tap)

        
        //CONFIGURE LOGIN BUTTON - AJE
        loginButton.backgroundColor = UIColor.white
        loginButton.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    //HIDE KEYBOARD WHEN TOUCHING ANYWHERE ON SCREEN - AJE
    func hideKeyboard(){
        
        view.endEditing(true)
    }
    
    //SETS CONTROL FLOW OF TEXT BOXES - AJE
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
            loginSpecifiedUser(email: emailField.text!, password: passwordField.text!)
        }
        return false
    }

    @IBAction func login(_ sender: AnyObject) {
        
        loginSpecifiedUser(email: emailField.text!, password: passwordField.text!)
    }
    
    @IBAction func createAccount(_ sender: AnyObject) {
        
        print("CREATE ACCOUNT")
    }
    
    func loginSpecifiedUser(email: String, password: String){
        
        //VALIDATE EMAIL/PASSWORD AND LOGIN - AJE
        if(emailField.text == ""){
            
            print("Please enter email address.")
        }else if(passwordField.text == ""){
            
            print("Please enter password.")
        }else{
        
            print("LOGGED IN \(email) with password \(password).")
        }
        
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
