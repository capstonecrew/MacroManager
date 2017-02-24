//
//  MealView2Controller.swift
//  MacroManager
//
//  Created by spencer on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit
import Alamofire

class MealView2Controller: UITableViewController, mealHeaderCellDelegate {
    
    
    
    // uncomment this to recieve item from segue
    var recievedNix: NixItem?
    var isFavorite: Bool?
    
    
    
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
        if let nix = recievedNix {
            return nix.miscNutrients.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailsCell") as! MealDetailsCell
        
        if let nix = recievedNix {
            cell.mainLbl.text = nix.miscNutrients[indexPath.row].name
            cell.accessoryLbl.text = "\(nix.miscNutrients[indexPath.row].amount)\(nix.miscNutrients[indexPath.row].units)"
        }
        
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
        cell.isFavorite = self.isFavorite!
        
        if(self.isFavorite!){
            cell.favoriteBtn.setImage(UIImage(named:"favoriteFilled"), for: .normal)
        }else{
            cell.favoriteBtn.setImage(UIImage(named:"favorite"), for: .normal)
        }
    
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 244.0
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func addFavorite(sender: MealHeaderCell)
    {
        let url = "https://www.googleapis.com/customsearch/v1?q=\(recievedNix?.itemName)&cx=000748290492374586623%3A00pjyzbfpy4&num=1&searchType=image&key=AIzaSyCvYEp9GQqoX-c99F8w5HvaaiEg_lU6dz4"
        
        
        let parameters: Parameters = ["key": "AIzaSyCvYEp9GQqoX-c99F8w5HvaaiEg_lU6dz4", "cx": "000748290492374586623%3A00pjyzbfpy4", "q": recievedNix!.itemName]
        
        let values = recievedNix!.itemName.components(separatedBy: CharacterSet.whitespaces.union(.punctuationCharacters))
        print(values)
        
        var q = String()
        
        if(values.count > 0){
            
            q = values[0]
            
            if values.count != 1{
                for i in 1...values.count - 1{
                    
                    if(values[i] != ""){
                        //q = "\(q)+\(value)"
                        q = q + "+" + values[i]
                    }
                }
            }
        }
        
        
        Alamofire.request("https://www.googleapis.com/customsearch/v1?q=\(q)&cx=000748290492374586623%3A00pjyzbfpy4&num=1&searchType=image&key=AIzaSyCvYEp9GQqoX-c99F8w5HvaaiEg_lU6dz4").responseJSON{ response in
            
            print(response.data)
            let searchResults = JSON(response.result.value!)
            print(searchResults)
            
            let imageUrl = searchResults["items"][0]["link"].string
            self.recievedNix?.imageUrl = imageUrl!
            currentUser.addMealToFavorite(mealEaten: self.recievedNix!)
            self.isFavorite = true
            
            let alertController = UIAlertController(title: "", message:"Favorite food added!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil))
            
            self.present(alertController,animated:true,completion:nil)
            
        }
    }
    
    func removeFavorite(sender: MealHeaderCell)
    {
        
        let alertController = UIAlertController(title: "", message:"Favorite food removed!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil))
        
        self.present(alertController,animated:true,completion:nil)
        currentUser.removeMealFromFavorite(mealEaten: recievedNix!)
        self.isFavorite = false
        
    }
    
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        self.addMealToHistory()
    }
    
    func addMealToHistory() {
        currentUser.addMealToLog(mealEaten: (self.recievedNix)!)
        self.dismiss(animated: true, completion: nil)
    }
}
