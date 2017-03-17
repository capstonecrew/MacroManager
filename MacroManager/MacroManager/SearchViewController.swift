//
//  SearchViewController.swift
//  MacroManager
//
//  Created by Alex Schultz on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var foodSearchResults:Array<NixItem> = []
    var numMealsLeft = 0
    
    var fatGoalTotal = 0;
    var proteinGoalTotal = 0;
    var carbGoalTotal = 0;
    var fatGoal = 0;
    var proteinGoal = 0;
    var carbGoal = 0;
    var fatToday = 0;
    var proteinToday = 0;
    var carbToday = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isEnabled = false
        searchBar.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Coolvetica", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
        
        if let font = UIFont(name: "Helvetica Neue Bold", size: 24) {
            doneButton.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState.normal)
        }
        
        //tableView.estimatedRowHeight = 110.0
        //tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // User data math for deciding recommended meals
        fatGoalTotal = currentUser.fatCount
        proteinGoalTotal = currentUser.proteinCount
        carbGoalTotal = currentUser.carbCount
        fatToday = currentUser.fatToday
        proteinToday = currentUser.proteinToday
        carbToday = currentUser.carbToday
        
        let totalNutrientsGoal = fatGoalTotal + proteinGoalTotal + carbGoalTotal
        let totalNutrientsToday = fatToday + proteinToday + carbToday
        
        if (totalNutrientsToday < (totalNutrientsGoal / 4)) {
            numMealsLeft = 3
        }
        else if (Double(totalNutrientsToday) < (Double(totalNutrientsGoal) * 0.6)) {
            numMealsLeft = 2
        }
        else {
            numMealsLeft = 1
        }
        
        fatGoal = (fatGoalTotal - fatToday) / numMealsLeft
        proteinGoal = (proteinGoalTotal - proteinToday) / numMealsLeft
        carbGoal = (carbGoalTotal - carbToday) / numMealsLeft
    }
    
    @IBAction func doneSearching(_ sender: Any) {
        self.view.endEditing(true)
        doneButton.isEnabled = false
    }
    
    
    func performSearch(searchText: String) {
        foodSearchResults.removeAll()
        
        NixApiManager.search(query: searchText, page: 0) { response in
            for item in response.value! {
                //Fill table view
                self.foodSearchResults.append(item)
                
            }
            
            
            // Refresh table view after new data
            self.tableView.reloadData()
        
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        var carbPercent = 0.0
        var proteinPercent = 0.0
        var fatPercent = 0.0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "meal", for: indexPath) as! SearchTableViewCell
        
        let item = self.foodSearchResults[indexPath.row]
        
        cell.mealNameLabel.text = item.itemName
        
        if item.itemDescription != " "{
            cell.descriptionLabel.text = item.itemDescription
        }else{
            cell.descriptionLabel.text = "No Description"
        }
        
        if let fats = item.fats {
            cell.fatLabel.text = "Fats: \(fats)"
            fatPercent = (fats / Double(fatGoal)) * 100.0
            
        } else {
            cell.fatLabel.text = "Fats: N/A"
        }
        
        if let proteins = item.proteins {
            cell.proteinLabel.text = "Protein: \(proteins)"
            proteinPercent = (proteins / Double(proteinGoal)) * 100.0
        } else {
            cell.proteinLabel.text = "Protein: N/A"
        }
        
        if let carbs = item.carbs {
            cell.carbsLabel.text = "Carbs: \(carbs)"
            carbPercent = (carbs / Double(carbGoal)) * 100.0
        } else {
            cell.carbsLabel.text = "Carbs: N/A"
        }
        
        // Quality calculations
        switch(currentUser.goal){
            case "Lose Fat":
                //Above 30% difference on all macros
                if ((carbPercent < 8   || carbPercent > 120) &&
                    (fatPercent < 8   || fatPercent > 120) &&
                    (proteinPercent < 8   || proteinPercent > 120)) {
                    cell.setQualityBad()
                }
                    //Below 20% difference on at least 2 macros and below 30% on the third
                else if ((carbPercent >= 8   && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else if ((carbPercent >= 8  && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else if ((carbPercent >= 8  && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else {
                    cell.setQualityOkay()
            }
            case "Maintain":
                //Above 30% difference on all macros
                if ((carbPercent < 8  || carbPercent > 120) &&
                    (fatPercent < 8  || fatPercent > 120) &&
                    (proteinPercent < 8  || proteinPercent > 120)) {
                    cell.setQualityBad()
                }
                    //Below 20% difference on at least 2 macros and below 30% on the third
                else if ((carbPercent >= 8  && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else if ((carbPercent >= 8  && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else if ((carbPercent >= 8  && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else {
                    cell.setQualityOkay()
            }
            case "Gain Muscle":
                //Above 30% difference on all macros
                if ((carbPercent < 8  || carbPercent > 120) &&
                    (fatPercent < 8  || fatPercent > 120) &&
                    (proteinPercent < 8  || proteinPercent > 120)) {
                    cell.setQualityBad()
                }
                    //Below 20% difference on at least 2 macros and below 30% on the third
                else if ((carbPercent >= 8  && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else if ((carbPercent >= 8  && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else if ((carbPercent >= 8  && carbPercent <= 120) &&
                    (fatPercent >= 8  && fatPercent <= 120) &&
                    (proteinPercent >= 8  && proteinPercent <= 120)){
                    cell.setQualityGood()
                }
                else {
                    cell.setQualityOkay()
            }
        default: break
        }
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMeal" {
            let selectedIndex: IndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
            if let vc = segue.destination as? UINavigationController{
                if let nextView: MealView2Controller = vc.childViewControllers[0] as? MealView2Controller {
                    nextView.recievedNix = foodSearchResults[selectedIndex.row]
                    nextView.isFavorite = currentUser.checkFavorite(itemId: foodSearchResults[selectedIndex.row].itemId)
                    print(nextView.isFavorite)
                    print(selectedIndex.row)
                }
            }
        }
    }
    
    /*func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            doneButton.isEnabled = true
            performSearch(searchText: text)
        }    
    }*/
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.view.endEditing(true)
            doneButton.isEnabled = false
            performSearch(searchText: text)
            currentUser.client.updatePoints(d: "search")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
