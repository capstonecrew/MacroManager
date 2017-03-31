//
//  SignInViewController.swift
//  MacroManager
//
//  Created by Capstone Crew on 10/31/16.
//  Copyright © 2016 Capstone Crew. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = true
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 1)
 
   
        //Backround color
        self.view.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        
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
        loginButton.layer.cornerRadius = 20
        
        loadingWheel.hidesWhenStopped = true
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
            
            self.loginButton.setTitle("", for: .normal)
            self.loadingWheel.startAnimating()
            loginSpecifiedUser(email: emailField.text!, password: passwordField.text!)
        }
        return false
    }

    @IBAction func login(_ sender: AnyObject) {
        
        
        self.loginButton.setTitle("", for: .normal)
        self.loadingWheel.startAnimating()
        loginSpecifiedUser(email: emailField.text!, password: passwordField.text!)
    }
    
    func loginSpecifiedUser(email: String, password: String){
        
        //VALIDATE EMAIL/PASSWORD AND LOGIN - AJE
        if(emailField.text == ""){
            
            print("Please enter email address.")
        }else if(passwordField.text == ""){
            
            print("Please enter password.")
        }else{
        
            print("LOGGED IN \(email) with password \(password).")
            
            FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user:FIRUser?, error:Error?) in
                
                print(user?.uid)
                
                if error != nil {
                    print(error?.localizedDescription)
                    
                    self.loadingWheel.stopAnimating()
                    self.loginButton.setTitle("LOGIN", for: .normal)
                    
                }else{
                    
                    print("logged in from sign in properly")
                    let userRef = FIRDatabase.database().reference().child("users").child((user!.uid))
                    
                    userRef.observeSingleEvent(of: .value, with: { (snapshot:FIRDataSnapshot) in
                        
                        print(snapshot)
                        let user = User.init(snap: snapshot)
                        currentUser = user
                        print(currentUser!.name!)
                        
                        let storedUser = currentUser!.toAnyObject()
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(storedUser, forKey: "currentUser") // set user default

                        //UserDefaults.standard.object(forKey: "currentUser") as! [String: Any]
                        print(currentUser)
                        
                        self.loadingWheel.stopAnimating()
                        self.loginButton.setTitle("WELCOME", for: .normal)
                        
                        self.performSegue(withIdentifier: "toDashboardView", sender: user)
                    })
                   
                }
            })            
        }
        
    }
    @IBAction func checkAcct(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindFromRegistration(segue:UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDashboardView"{
            
            
        }
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
