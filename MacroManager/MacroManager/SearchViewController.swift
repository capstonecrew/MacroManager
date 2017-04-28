//
//  SearchViewController.swift
//  MacroManager
//
//  Created by Alex Schultz on 1/26/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var foodSearchResults:Array<GenericFoodItem> = []

    var recipeSearchResults:Array<RecipeItem> = []

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

    var percentFilter = 1.0
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.29, green:0.55, blue:0.90, alpha:1.0)

        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Coolvetica", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
        
       // performBestMealLookup(clearCurrentResults: true, percent: self.percentFilter)
        
//        if let font = UIFont(name: "Helvetica Neue Bold", size: 24) {
//            doneButton.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState.normal)
//        }
        
//        EdamamApiManager.search(query: "mac and cheese", count: 30) { response in
//            for item in response.value! {
//                
//                print(item.itemName)
//                //self.recipeSearchResults.append(item)
//                
//            }
//        }
//        
//        YummlyApiManager.search(query: "mac and cheese", count: 10, completionHandler: { response in
//            
//            for item in response.value! {
//                print(item.itemName)
//                
//            }
//            
//        })
        
        //tableView.estimatedRowHeight = 110.0
        //tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //HIDE KEYBOARD WHEN TOUCHING ANYWHERE ON SCREEN - AJE
    func hideKeyboard(){
        
        view.endEditing(true)
        self.view.removeGestureRecognizer(tap)
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
        
        //Populate with best recommendations
        //performBestMealLookup(clearCurrentResults: true, percent: self.percentFilter)
    }
    
//    @IBAction func doneSearching(_ sender: Any) {
//        self.view.endEditing(true)
//        doneButton.isEnabled = false
//    }
    
    
    func performSearch(searchText: String) {
        foodSearchResults.removeAll()
        foodSearchResults = foodSearchResults + currentUser.customMealList
//        NixApiManager.search(query: searchText, page: 0) { response in
//            for item in response.value! {
//                //Fill table view
//                self.foodSearchResults.append(item)
//                
//            }
//            
//            // Refresh table view after new data
//            self.tableView.reloadData()
//        
//        }
        
        let lookupGroup = DispatchGroup()
        
        lookupGroup.enter()
        YummlyApiManager.search(query: searchText, count: 20, completionHandler: { response in
            
            for item in response.value!{
                self.calculateQuality(item: item)
                self.foodSearchResults.append(item)
            }
            
            lookupGroup.leave()
            
        })
        
        lookupGroup.enter()
        EdamamApiManager.search(query: searchText, count: 20, completionHandler: { response in
            
            for item in response.value!{
                self.calculateQuality(item: item)
                self.foodSearchResults.append(item)
            }
            
            lookupGroup.leave()
            
        })
        
        lookupGroup.notify(queue: .main, execute: {
            self.foodSearchResults.sort(by: self.sorterForItemsByQuality)
            self.tableView.reloadData()
        })
    }
    
    func performBestMealLookup(clearCurrentResults : Bool, percent: Double ) {
        if (clearCurrentResults){
            self.foodSearchResults.removeAll()
        }
        
        YummlyApiManager.percentSearch(query: "", count: 20, percent: Double(percent), carbCount: Double(carbGoal), proteinCount: Double(proteinGoal), fatCount: Double(fatGoal), completionHandler: { response in
            
            for item in response.value!{
                self.calculateQuality(item: item)
                self.foodSearchResults.append(item)
            }
            
            self.minimumResultsCheck()
            
        })
        
        self.tableView.reloadData()
    }
    
    func minimumResultsCheck () -> Void {
        if (self.foodSearchResults.count < 20) {
            self.percentFilter += 1
            performBestMealLookup(clearCurrentResults: false, percent: self.percentFilter)
        }
    }
    
    func sorterForItemsByQuality(first: GenericFoodItem, second: GenericFoodItem) -> Bool {
        if first.quality == .good {
            return true
        }
        else if (first.quality == .bad && (second.quality == .okay || second.quality == .good)) {
            return false
        }
        else if (first.quality == .okay && (second.quality == .good)) {
            return false
        }
        else {
            return true
        }
    }
    
    func calculateQuality(item : GenericFoodItem) {
        var carbPercent = 0.0
        var proteinPercent = 0.0
        var fatPercent = 0.0
        
        fatPercent = (item.fats / Double(fatGoal)) * 100.0
        proteinPercent = (item.proteins / Double(proteinGoal)) * 100.0
        carbPercent = (item.carbs / Double(carbGoal)) * 100.0

        // Quality calculations
        switch(currentUser.goal){
        case "Lose Fat":
            //Above 30% difference on all macros
            if ((carbPercent < 70   || carbPercent > 130) &&
                (fatPercent < 70   || fatPercent > 130) &&
                (proteinPercent < 70   || proteinPercent > 130)) {
                item.quality = .bad
            }
                //Below 20% difference on at least 2 macros and below 30% on the third
            else if ((carbPercent >= 70   && carbPercent <= 120) &&
                (fatPercent >= 80  && fatPercent <= 120) &&
                (proteinPercent >= 80  && proteinPercent <= 120)){
                item.quality = .good
            }
            else if ((carbPercent >= 80  && carbPercent <= 120) &&
                (fatPercent >= 70  && fatPercent <= 120) &&
                (proteinPercent >= 80  && proteinPercent <= 120)){
                item.quality = .good
            }
            else if ((carbPercent >= 80  && carbPercent <= 120) &&
                (fatPercent >= 80  && fatPercent <= 120) &&
                (proteinPercent >= 70  && proteinPercent <= 120)){
                item.quality = .good
            }
            else {
                item.quality = .okay
            }
        case "Maintain":
            //Above 30% difference on all macros
            if ((carbPercent < 8  || carbPercent > 120) &&
                (fatPercent < 8  || fatPercent > 120) &&
                (proteinPercent < 8  || proteinPercent > 120)) {
                item.quality = .bad
            }
                //Below 20% difference on at least 2 macros and below 30% on the third
            else if ((carbPercent >= 8  && carbPercent <= 120) &&
                (fatPercent >= 8  && fatPercent <= 120) &&
                (proteinPercent >= 8  && proteinPercent <= 120)){
                item.quality = .good
            }
            else if ((carbPercent >= 8  && carbPercent <= 120) &&
                (fatPercent >= 8  && fatPercent <= 120) &&
                (proteinPercent >= 8  && proteinPercent <= 120)){
                item.quality = .good
            }
            else if ((carbPercent >= 8  && carbPercent <= 120) &&
                (fatPercent >= 8  && fatPercent <= 120) &&
                (proteinPercent >= 8  && proteinPercent <= 120)){
                item.quality = .good
            }
            else {
                item.quality = .okay
            }
        case "Gain Muscle":
            //Above 30% difference on all macros
            if ((carbPercent < 8  || carbPercent > 120) &&
                (fatPercent < 8  || fatPercent > 120) &&
                (proteinPercent < 8  || proteinPercent > 120)) {
                item.quality = .bad
            }
                //Below 20% difference on at least 2 macros and below 30% on the third
            else if ((carbPercent >= 8  && carbPercent <= 120) &&
                (fatPercent >= 8  && fatPercent <= 120) &&
                (proteinPercent >= 8  && proteinPercent <= 120)){
                item.quality = .good
            }
            else if ((carbPercent >= 8  && carbPercent <= 120) &&
                (fatPercent >= 8  && fatPercent <= 120) &&
                (proteinPercent >= 8  && proteinPercent <= 120)){
                item.quality = .good
            }
            else if ((carbPercent >= 8  && carbPercent <= 120) &&
                (fatPercent >= 8  && fatPercent <= 120) &&
                (proteinPercent >= 8  && proteinPercent <= 120)){
                item.quality = .good
            }
            else {
                item.quality = .okay
            }
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "meal", for: indexPath) as! SearchTableViewCell
        let item = self.foodSearchResults[indexPath.row]
        let circleFilter = CircleFilter()
        cell.itemImage.af_setImage(withURL: URL(string: item.imageUrl)!, placeholderImage: UIImage(named: "placeholder"), filter: circleFilter)
        
        cell.mealNameLabel.text = item.itemName
        
        if item.itemDescription != " "{
            cell.descriptionLabel.text = item.itemDescription
        }else{
            cell.descriptionLabel.text = "No Description"
        }
        
        cell.descriptionLabel.isHidden = true
        
        cell.fatLabel.text = "Fats: \(item.fats)"
        
        cell.proteinLabel.text = "Protein: \(item.proteins)"
        
        cell.carbsLabel.text = "Carbs: \(item.carbs)"
        
        switch(item.quality) {
        case .bad:
            cell.setQualityBad()
            
        case .okay:
            cell.setQualityOkay()
            
        case .good:
            cell.setQualityGood()
            
        default: break
        }
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMeal" {
            let selectedIndex: IndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
            if let vc = segue.destination as? UINavigationController{
                if let nextView: MealView2Controller = vc.childViewControllers[0] as? MealView2Controller {
                    nextView.recievedItem = foodSearchResults[selectedIndex.row]
                    nextView.isFavorite = currentUser.checkFavorite(itemId: foodSearchResults[selectedIndex.row].itemId)
                    print(nextView.isFavorite)
                    print(selectedIndex.row)
                }
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tap)
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
            //doneButton.isEnabled = false
            performSearch(searchText: text)
            currentUser.client.updatePoints(d: "search")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
