//
//  MealView2Controller.swift
//  MacroManager
//
//  Created by spencer on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class MealView2Controller: UITableViewController, mealHeaderCellDelegate {
    
    
    
    // uncomment this to recieve item from segue
    var recievedNix: NixItem?
    
    
    
    //dummy nix item for test
    //var recievedNix = NixItem(itemName: "Hamburger", itemId: "001010", itemDescription: "", fats: 400.0, proteins: 200.0, carbs: 100.0)
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        tableView.register(UINib(nibName: "MealHeaderCell", bundle: nil), forCellReuseIdentifier: "mealHeaderCell")
        tableView.register(UINib(nibName: "MealDetailsCell", bundle: nil), forCellReuseIdentifier: "mealDetailsCell")
        self.navigationItem.title = "Food Detail"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
        if let font = UIFont(name: "Helvetica Neue Bold", size: 24) {
            self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState.normal)
        }
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = .white
        
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailsCell") as! MealDetailsCell
        
        return cell
   
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealHeaderCell") as! MealHeaderCell
        cell.parentVC = self; // add reference to this vc in the tableviewcell
    
    
        if let nix = recievedNix {
            cell.foodNameLabel.text = nix.itemName
            
            if  let prot = nix.proteins {
                cell.proteinsAmount.text = "\(prot) g"
            }
            else {
                cell.proteinsAmount.text = "N/A"
                nix.proteins = 0
            }
            
            if let carb = nix.carbs {
                cell.carbsAmount.text = "\(carb) g"
            }
            else {
                cell.carbsAmount.text = "N/A"
                nix.carbs = 0
            }
            
            if let fat = nix.fats {
                cell.fatsAmount.text = "\(fat) g"
            }
            else {
                cell.fatsAmount.text = "N/A"
                nix.fats = 0
            }
        
        } 
        else {
            print("COULD NOT FETCH NIX ITEM")
        }
        cell.delegate = self
    
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 244.0
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func dismiss(sender: MealHeaderCell) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addFavorite(sender: MealHeaderCell)
    {
        
        let alertController = UIAlertController(title: "", message:"Favorite food added!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title:"Dismiss", style:UIAlertActionStyle.default, handler:nil))
        
        self.present(alertController,animated:true,completion:nil)
        currentUser.addMealToFavorite(mealEaten: recievedNix!)
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
