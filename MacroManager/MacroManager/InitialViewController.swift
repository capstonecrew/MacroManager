//
//  InitialViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 1/12/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        loginBtn.backgroundColor = UIColor(red:0.29, green:0.55, blue:0.90, alpha:1.0)
        loginBtn.layer.cornerRadius = 20
        
        signUpBtn.backgroundColor = .white
        signUpBtn.layer.cornerRadius = 20
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginPressed(_ sender: Any) {
    
        self.performSegue(withIdentifier: "toLoginScreen", sender: self)
    }

    @IBAction func signUpPressed(_ sender: Any) {
    
        self.performSegue(withIdentifier: "toRegistrationScreen", sender: self)
    }
}
