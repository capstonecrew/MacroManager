//
//  AddCustomMealViewController.swift
//  MacroManager
//
//  Created by Alex Schultz on 2/22/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class AddCustomMealViewController: UITableViewController, CustomMealHeaderCellDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        tableView.register(UINib(nibName: "CustomMealHeaderCell", bundle: nil), forCellReuseIdentifier: "customMealHeaderCell")
        tableView.register(UINib(nibName: "CustomMealDetailCellTableViewCell", bundle: nil), forCellReuseIdentifier: "customMealDetailCellTableViewCell")
        self.navigationItem.title = "Custom Meal"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
        if let font = UIFont(name: "Helvetica Neue Bold", size: 24) {
            self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState.normal)
        }
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = .white

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMealDetailCellTableViewCell") as! CustomMealDetailCellTableViewCell
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMealHeaderCell") as! CustomMealHeaderCell
                
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 244.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func addFavorite(sender: CustomMealHeaderCell)
    {
        
        let alertController = UIAlertController(title: "", message:"Favorite food added!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil))
        
        self.present(alertController,animated:true,completion:nil)
        //currentUser.addMealToFavorite(mealEaten: recievedNix!)
        //self.isFavorite = true
        
    }
    
    func removeFavorite(sender: CustomMealHeaderCell)
    {
        
        let alertController = UIAlertController(title: "", message:"Favorite food removed!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil))
        
        self.present(alertController,animated:true,completion:nil)
        //currentUser.removeMealFromFavorite(mealEaten: recievedNix!)
        //self.isFavorite = false
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addMealToHistory() {
        //currentUser.addMealToLog(mealEaten: (self.recievedNix)!)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func SaveCustomMeal(_ sender: Any) {
        currentUser.addCustomMeal(itenName: "testName", itemDescription: "testDesc", fats: 11.0, proteins: 11.0, carbs: 11.0)
        print("added meal")
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
