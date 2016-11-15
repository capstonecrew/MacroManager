//
//  dataTestViewController.swift
//  MacroManager
//
//  Created by Alex Schultz on 11/8/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit
import CoreData

class dataTestViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    
    var fromName = String() // set by regView
    var fromEmail = String() // set by regView
    var fromPassword = String() // set by regView
    var fromAge = Int() // set by details
    var fromWeight = Int() // set by details
    var fromHeight = String() // set by details
    var fromGoals = Int() // from goalSlider
    
    var index: Int = 0
    var max: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveToCD()
        sleep(1)
        getTranscriptions(ind: index) // fetch CD

        // Do any additional setup after loading the view.
    }
    
    func saveToCD() {
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
        transc.setValue(fromGoals, forKey: "goal")
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    
    func getTranscriptions(ind: Int) {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<UserEnt> = UserEnt.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            print("max is \(searchResults.count)")
            max = searchResults.count
            
            nameLabel.text = searchResults[ind].value(forKey: "name") as! String?
            ageLabel.text = "\(searchResults[ind].value(forKey: "age") as! Int)"
            emailLabel.text = searchResults[ind].value(forKey: "email") as! String?
            passwordLabel.text = searchResults[ind].value(forKey: "password") as! String?
            heightLabel.text = searchResults[ind].value(forKey: "height") as! String?
            weightLabel.text = "\(searchResults[ind].value(forKey: "weight") as! Int)"
            goalLabel.text = "\(searchResults[ind].value(forKey: "goal") as! Int)"
                
        } catch {
            print("Error with request: \(error)")
        }
        
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func nextButton(_ sender: Any) {
        print("index is \(index) and max is \(max)")
        print("next")
        if index < max - 1 {
            index = index + 1
            getTranscriptions(ind: index)
        }
    }

    @IBAction func prevButton(_ sender: Any) {
        print("index is \(index) and max is \(max)")
        print("prev")
        if index > 0 {
            index = index - 1
            getTranscriptions(ind: index)
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
