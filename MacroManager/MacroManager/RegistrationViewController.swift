//
//  RegistrationViewController.swift
//  MacroManager
//
//  Created by Capstone Crew on 10/31/16.
//  Copyright © 2016 Capstone Crew. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        //self.navigationController?.navigationBar.tintColor = .white
       // self.navigationController?.navigationBar.isTranslucent = false
        
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 1)
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white

        //Backround color
        self.view.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        
        //SETS STATUS BAR TO WHITE - AJE
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        //CONFIGURE TEXT BOXES - AJE
        nameField.attributedPlaceholder = NSAttributedString(string:"NAME",
                                                              attributes:[NSForegroundColorAttributeName: UIColor.white])
        nameField.borderStyle = .none
        nameField.textColor = UIColor.white
        nameField.tag = 0
        nameField.delegate = self
        nameField.returnKeyType = .next
        nameField.keyboardType = .default
        nameField.autocapitalizationType = .words
        nameField.autocorrectionType = .no
        nameField.tintColor = UIColor.white
        
        emailField.attributedPlaceholder = NSAttributedString(string:"EMAIL",
                                                              attributes:[NSForegroundColorAttributeName: UIColor.white])
        emailField.borderStyle = .none
        emailField.textColor = UIColor.white
        emailField.tag = 1
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
        passwordField.tag = 2
        passwordField.delegate = self
        passwordField.returnKeyType = .continue
        passwordField.isSecureTextEntry = true
        passwordField.keyboardType = .default
        passwordField.autocapitalizationType = .none
        passwordField.tintColor = UIColor.white
        
        //GESTURE RECOGNIZER TO HIDE KEYBOARD - AJE
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
        
        //CONFIGURE LOGIN BUTTON - AJE
        nextButton.backgroundColor = UIColor.white
        nextButton.layer.cornerRadius = 20
        
        self.loadingWheel.hidesWhenStopped = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
    }
    
    //HIDE KEYBOARD WHEN TOUCHING ANYWHERE ON SCREEN - AJE
    func hideKeyboard(){
    
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("lol")
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

    /* send data to registrationViewController to later be added to CD */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "regToDetail" {
            print("sending 3 fields to regView")
            if let nextView: DetailsViewController = segue.destination as? DetailsViewController {
                nextView.fromName = nameField.text!
                nextView.fromEmail = emailField.text!
                nextView.fromPassword = passwordField.text!
            }
        }
    }
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
    
        registerUserWithFirebase()
    }
    
    func registerUserWithFirebase(){
        
        self.nextButton.setTitle("", for: .normal)
        self.loadingWheel.startAnimating()
        FIRAuth.auth()?.createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: {(user, error) in
            
            if error != nil{
                self.loadingWheel.stopAnimating()
                if error?.localizedDescription == "The password must be 6 characters long or more."{
                
                    self.nextButton.setTitle("SIGN UP", for: .normal)
                    let alertView = UIAlertController(title: "Invalid Password", message: "The password must be 6 characters long or more.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertView.addAction(action)
                    self.present(alertView, animated: true, completion: nil)
                    
                }else if error?.localizedDescription == "The email address is already in use by another account."{
                    
                    self.nextButton.setTitle("SIGN UP", for: .normal)
                    let alertView = UIAlertController(title: "Invalid Email", message: "The email address is already in use by another account.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertView.addAction(action)
                    self.present(alertView, animated: true, completion: nil)

                }
            }else{
                self.loadingWheel.stopAnimating()
                self.performSegue(withIdentifier: "regToDetail", sender: self)
            }
        })

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindFromDetails(segue:UIStoryboardSegue) {
        
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
