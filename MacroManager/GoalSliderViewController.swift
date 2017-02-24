//
//  GoalSliderViewController.swift
//  MacroManager
//
//  Created by Capstone Crew on 10/31/16.
//  Copyright © 2016 Capstone Crew. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseDatabase

class GoalSliderViewController: UIViewController {

   
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loseWeight: UIButton!
    @IBOutlet weak var maintainWeight: UIButton!
    @IBOutlet weak var gainWeight: UIButton!
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    
    var previousBtn: UIButton!
    
    var fromName: String! // set by regView
    var fromEmail: String! // set by regView
    var fromPassword: String! // set by regView
    var fromAge: String! // set by details
    var fromWeight: String! // set by details
    var fromHeight: String! // set by details
    var fromActivity: String!
    var fromGender: String!
    var goalSelected: String!
    var selectedTag: Int!
    
    let goalOptions : [String] = ["Lose Fat", "Maintain", "Gain Muscle"]

    var dbRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference()
        
        //Backround color
        self.view.backgroundColor = UIColor(red: 0.29, green: 0.55, blue: 0.9, alpha: 1.0)
        
        signUpButton.backgroundColor = UIColor.white
        signUpButton.layer.cornerRadius = 20
        
        loseWeight.backgroundColor = .white
        loseWeight.layer.cornerRadius = 20
        loseWeight.tag = 0
        loseWeight?.titleLabel?.textColor = .lightGray
        
        maintainWeight.backgroundColor = .white
        maintainWeight.layer.cornerRadius = 20
        maintainWeight.tag = 1
        maintainWeight?.titleLabel?.textColor = .lightGray
        
        gainWeight.backgroundColor = .white
        gainWeight.layer.cornerRadius = 20
        gainWeight.tag = 2
        gainWeight?.titleLabel?.textColor = .lightGray
        
        loseWeight.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        gainWeight.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
        maintainWeight.addTarget(self, action: #selector(GoalSliderViewController.selected), for: .touchUpInside)
    
        loadingWheel.hidesWhenStopped = true
    }

    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    @IBAction func registerUser(_ sender: Any) {
    
        self.signUpButton.setTitle("", for: .normal)
        self.loadingWheel.startAnimating()
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth:FIRAuth, user:FIRUser?) in
            if let user = user {
                
                let userRef = self.dbRef.child("users").child(user.uid)
                
                let user = User(name: self.fromName, age: Int(self.fromAge), gender: self.fromGender, height: self.fromHeight, weight: Int(self.fromWeight), activityLevel: self.fromActivity, goal: self.goalSelected)
                userRef.setValue(user.toAnyObject())
                
                user.calorieCalc() // update users daily calories
                user.macronutrientCalc() // update users daily macro count
                
                currentUser = user
                
                self.loadingWheel.stopAnimating()
                self.signUpButton.setTitle("Welcome \(currentUser.name)!", for: .normal)
                self.performSegue(withIdentifier: "toDashboard", sender: self)
                
            }else{
                print("No user signed in.")
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "goalsToData" {
//            print("sending 7 fields to dataViewController")
//            if let nextView: dataTestViewController = segue.destination as? dataTestViewController {
//                nextView.fromName = fromName
//                nextView.fromEmail = fromEmail
//                nextView.fromPassword = fromPassword
//                nextView.fromAge = fromAge
//                nextView.fromWeight = fromWeight
//                nextView.fromHeight = fromHeight
//              
//            }
//        }
        
        if segue.identifier == "toDashboard"{
            print("toDashboard")
        }
        
    }
    
    func selected(sender: UIButton){
        
        if(previousBtn != nil){
            previousBtn!.backgroundColor = .white
            previousBtn!.tintColor = .lightGray
        }
        
        let selectedBtn = sender as UIButton
        selectedBtn.backgroundColor = .darkGray
        selectedBtn.tintColor = .white
        
        goalSelected = goalOptions[selectedBtn.tag]
        
        previousBtn = selectedBtn
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hi gregg write code here
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
