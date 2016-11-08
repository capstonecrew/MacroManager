//
//  GoalSliderViewController.swift
//  MacroManager
//
//  Created by Capstone Crew on 10/31/16.
//  Copyright © 2016 Capstone Crew. All rights reserved.
//

import UIKit
import CoreData

class GoalSliderViewController: UIViewController {

    @IBOutlet weak var goalSlider: UISlider!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    var fromName = String() // set by regView
    var fromEmail = String() // set by regView
    var fromPassword = String() // set by regView
    var fromAge = Int() // set by details
    var fromWeight = Int() // set by details
    var fromHeight = String() // set by details
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalSlider.minimumValue = 0
        goalSlider.maximumValue = 90
        
        goalSlider.tintColor = UIColor.lightGray
        goalSlider.thumbTintColor = UIColor(red:0.17, green:0.57, blue:0.56, alpha:1.0)
        
        signUpButton.backgroundColor = UIColor.white
        signUpButton.layer.cornerRadius = 5
    
        // Do any additional setup after loading the view.
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
        
        
        if(goalSlider.value >= 0 && goalSlider.value < 30){
            
            goalLabel.text = "LOSE WEIGHT"
            
        }else if (goalSlider.value >= 30 && goalSlider.value < 60){
            
            goalLabel.text = "MAINTAIN WEIGHT"
        
        }else{
        
            goalLabel.text = "GAIN WEIGHT"
        }
    }
    
    @IBAction func saveToCoreData(_ sender: Any) {
        print("saving to core data")
        let context = getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "UserEnt", in: context)
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        transc.setValue(fromName, forKey: "name")
        transc.setValue(fromAge, forKey: "age")
        transc.setValue(fromEmail, forKey: "email")
        transc.setValue(fromPassword, forKey: "password")
        transc.setValue(fromWeight, forKey: "weight")
        transc.setValue(fromHeight, forKey: "height")
        transc.setValue(Int(goalSlider.value), forKey: "goal")
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goalsToData" {
            print("sending 7 fields to dataViewController")
            if let nextView: GoalSliderViewController = segue.destination as? GoalSliderViewController {
                nextView.fromName = fromName
                nextView.fromEmail = fromEmail
                nextView.fromPassword = fromPassword
                nextView.fromAge = Int(ageField.text!)!
                nextView.fromWeight = Int(weightField.text!)!
                nextView.fromHeight = heightField.text!
            }
        }
    }*/
    
    
    
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
