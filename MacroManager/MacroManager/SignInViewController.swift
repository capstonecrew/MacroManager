//
//  SignInViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 10/31/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.placeholder = "EMAIL"
        passwordField.placeholder = "PASSWORD"
        
        emailField.textColor = UIColor.white
        passwordField.textColor = UIColor.white
        
        emailField.borderStyle = .none
        passwordField.borderStyle = .none
        
        
        // Do any additional setup after loading the view.
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
