//
//  MealView2Controller.swift
//  MacroManager
//
//  Created by spencer on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit
import Alamofire
import Firebase


class MealView2Controller: UITableViewController, mealHeaderCellDelegate {
    
    
    
    // uncomment this to recieve item from segue
    var recievedItem: GenericFoodItem?
    var isFavorite: Bool?
    var uid: String!
    var ref: FIRDatabaseReference!

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
        
        uid = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference()
        
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
        if let nix = recievedItem {
            return nix.miscNutrients.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailsCell") as! MealDetailsCell
        
        if let nix = recievedItem {
            cell.mainLbl.text = nix.miscNutrients[indexPath.row].name
            cell.accessoryLbl.text = "\(nix.miscNutrients[indexPath.row].amount)\(nix.miscNutrients[indexPath.row].units)"
        }
        
        return cell
   
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealHeaderCell") as! MealHeaderCell
        cell.parentVC = self; // add reference to this vc in the tableviewcell
    
    
        if let nix = recievedItem {
            
            cell.foodNameLabel.text = nix.itemName
            cell.proteinsAmount.text = "\(Int(nix.proteins)) g"
            cell.carbsAmount.text = "\(Int(nix.carbs)) g"
            cell.fatsAmount.text = "\(Int(nix.fats)) g"
            cell.itemImage.af_setImage(withURL: URL(string: nix.imageUrl)!, placeholderImage: UIImage(named: "placeholder"))
            
        }else {
            print("COULD NOT FETCH NIX ITEM")
        }
        cell.delegate = self
        cell.isFavorite = self.isFavorite!
        
        if(self.isFavorite!){
            cell.favoriteBtn.setImage(UIImage(named:"favoriteFilled"), for: .normal)
        }else{
            cell.favoriteBtn.setImage(UIImage(named:"favorite"), for: .normal)
        }
    
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 196.0
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func addFavorite(sender: MealHeaderCell)
    {

        print(recievedItem?.itemId)
        let favoriteRef = ref.child("favorites").child(uid).child(recievedItem!.itemId)
        favoriteRef.setValue(recievedItem?.toAnyObject()) { (error, ref) in
            
            currentUser.addMealToFavorite(mealEaten: self.recievedItem!)
            self.isFavorite = true
            self.performSegue(withIdentifier: "showAddedAlert", sender: self)
            
        }

       
       /*
        let userId = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        
        let favoriteRef = ref.child("favorites").child(userId!).child((recievedItem?.itemId)!)
        favoriteRef.setValue(recievedItem?.toAnyObject())
        
       // currentUser.addMealToFavorite(mealEaten: self.recievedItem!)
 */
       /*
        let userId = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        
        let favoriteRef = ref.child("favorites").child(userId!).childByAutoId()
        favoriteRef.setValue(recievedItem?.toAnyObject())
        self.isFavorite = true
        
        self.performSegue(withIdentifier: "showAddedAlert", sender: self)
*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAddedAlert" {
            if let nextView: CustomAlertViewController = segue.destination as? CustomAlertViewController {
                nextView.added = true
            }
        }else if segue.identifier == "showRemovedAlert" {
            if let nextView: CustomAlertViewController = segue.destination as? CustomAlertViewController {
                nextView.added = false
            }
        }
    }
    
    func removeFavorite(sender: MealHeaderCell)
    {
       // currentUser.removeMealFromFavorite(mealEaten: recievedItem!)
        self.isFavorite = false
        
        let userId = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        
        let favoriteRef = ref.child("favorites").child(userId!).child((recievedItem?.itemId)!)
        favoriteRef.removeValue()
        
        self.performSegue(withIdentifier: "showRemovedAlert", sender: self)
        
    }
    
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if isFavorite == true {
            currentUser.client.updatePoints(d: "eatFav")
        }
        currentUser.client.updatePoints(d: "eatMeal")
        self.addMealToHistory()
        
    }
    
    func addMealToHistory() {

        let userId = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        
        let historyRef = ref.child("history").child(userId!).childByAutoId()
        historyRef.setValue(recievedItem?.toAnyObject())
    

      //  currentUser.addMealToLog(mealEaten: (self.recievedItem)!)
        self.dismiss(animated: true, completion: {
            self.tabBarController?.selectedIndex = 0
        })
    }
}






