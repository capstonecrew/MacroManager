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
    
    var index: Int = 0
    var max: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTranscriptions(ind: index) // fetch CD

        // Do any additional setup after loading the view.
    }
    
    func getTranscriptions(ind: Int) {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<UserEnt> = UserEnt.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
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
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if index < max - 1 {
            index = index + 1
            getTranscriptions(ind: index)
        }
    }

    @IBAction func prevButton(_ sender: Any) {
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
