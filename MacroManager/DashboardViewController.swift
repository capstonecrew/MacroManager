//
//  DashboardViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase

class DashboardViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, FoodCollectionCellDelegate, SuggestedFoodsCellDelegate, DailyGoalProgressCellDelegate {
    var historyMealLog = [GenericFoodItem]()
    var favoritesMealLog = [GenericFoodItem]()
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        tableView.register(UINib(nibName: "WelcomeUserCell", bundle: nil), forCellReuseIdentifier: "welcomeUserCell")
        tableView.register(UINib(nibName: "DailyGoalProgressCell", bundle: nil), forCellReuseIdentifier: "dailyGoalProgressCell")
        tableView.register(UINib(nibName: "SuggestedFoodsCell", bundle: nil), forCellReuseIdentifier: "suggestedFoodsCell")
        tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "headerCell")
        tableView.register(UINib(nibName: "MealDetailsCell", bundle: nil), forCellReuseIdentifier: "mealDetailsCell")

        self.navigationItem.title = "macro manager"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Coolvetica", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SuggestedFoodsCell
        cell.foodsCollectionView.reloadData()
        animateBarGraph()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numRows = 0
        
        switch section {
        case 0:
            numRows = 2
        case 1:
            numRows = historyMealLog.count
        default:
            break
        }
        
        return numRows
    }
    
    /*
     get user ID
     let userID = FIRAuth.auth()?.currentUser?.uid
     reference to the DB
     let ref = FIRDatabase.database().reference()
     ref to child node of history if one exists, making an auto ID for the child, in which you can set my the .setValue method
     let historyRef = ref.child("history").child(userID!).childByAutoId()
     historyRef.setValue(recievedItem?.toAnyObject())
     */
    
    func loadData()
    {
        historyMealLog = [GenericFoodItem]()
        let userID = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        let historyRef = ref.child("history").child(userID!)
        
        let lookupGroup = DispatchGroup()
        
        lookupGroup.enter()
        
        historyRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            for item in snapshot.children{
                let historyItem = GenericFoodItem.init(snap: item as! FIRDataSnapshot)
                self.historyMealLog.append(historyItem)
            }
            
            lookupGroup.leave()
        }
        
        
        lookupGroup.enter()
        favoritesMealLog = [GenericFoodItem]()
        currentUser.favoriteLog = [GenericFoodItem]()
        let favoritesRef = ref.child("favorites").child(userID!)
        favoritesRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            for item in snapshot.children{
                let favoritesItem = GenericFoodItem.init(snap: item as!  FIRDataSnapshot)
                self.favoritesMealLog.append(favoritesItem)
                currentUser.favoriteLog.append(favoritesItem)
                
            }
            
            lookupGroup.leave()
        }
        
        lookupGroup.notify(queue: .main, execute: {
            
            print(self.favoritesMealLog.count)
            self.tableView.reloadData()
        })
        
       

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
        
        switch section {
        case 0:
            cell.headerLbl.text = "Overview"
        case 1:
            cell.headerLbl.text = "History"
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height: CGFloat = 44.0
        
        switch section {
        case 0:
            height = 0.0
        case 1:
            height = 44.0
        default:
            break
        }
        
        return height
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            if(indexPath.row == 0){
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "suggestedFoodsCell") as! SuggestedFoodsCell
                
                cell.foodsCollectionView.delegate = self
                cell.foodsCollectionView.dataSource = self
                cell.foodsCollectionView.register(UINib(nibName: "FoodCollectionCell", bundle: nil), forCellWithReuseIdentifier: "foodCollectionCell")
                
                if(favoritesMealLog.count != 0){
                    cell.addFavoriteBtn.isHidden = true
                }else{
                    cell.addFavoriteBtn.isHidden = false
                }
                
                cell.foodsCollectionView.collectionViewLayout.accessibilityScroll(.right)
                cell.foodsCollectionView.reloadData()
                cell.delegate = self
                
                return cell
                
            }else if(indexPath.row == 1){
                let cell = tableView.dequeueReusableCell(withIdentifier: "dailyGoalProgressCell") as! DailyGoalProgressCell
                cell.proteinLabel.text = "Proteins"
                cell.proteinRatioLbl.text = "\(currentUser.proteinToday!) / \(currentUser.proteinCount!) g"
                cell.carbLabel.text = "Carbs"
                cell.carbsRatioLbl.text = "\(currentUser.carbToday!) / \(currentUser.carbCount!) g"
                cell.fatLabel.text = "Fats"
                cell.fatsRatioLbl.text = "\(currentUser.fatToday!) / \(currentUser.fatCount!) g"
                cell.delegate = self
                return cell
            }

        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailsCell") as! MealDetailsCell
            cell.accessoryLbl.isHidden = true
            cell.mainLbl.text = historyMealLog[indexPath.row].itemName
            return cell
            
        default:
            break
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            animateBarGraph()
        case 1:
            self.performSegue(withIdentifier: "showMeal", sender: indexPath)
        default:
            break
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            if(indexPath.row == 0){
                
                return 130.0
                
            }else if(indexPath.row == 1){
                
                return 210.0
            }
        case 1:
            
            return 44.0
            
        default:
            break
        }

        return 39.0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCollectionCell", for: indexPath) as!FoodCollectionCell
        cell.tag = indexPath.row
        cell.foodLbl.text = favoritesMealLog[indexPath.row].itemName
        cell.foodImageView.af_setImage(withURL: URL(string: favoritesMealLog[indexPath.row].imageUrl)! , placeholderImage: UIImage(named: "placeholder"), filter: CircleFilter())
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected indexPath: \(indexPath.section), \(indexPath.row)")
        self.performSegue(withIdentifier: "showFavoriteMeal", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesMealLog.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func animateBarGraph(){
        print("animating bar graph")
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DailyGoalProgressCell
        
        var progress = Float(currentUser.proteinToday!)/Float(currentUser.proteinCount!)
        if (progress >= 1)
        {
            currentUser.client.updatePoints(d: "goals")
        }
        print(progress)
        cell.proteinProgress.setProgress(progress, animated: true)
        
        progress = Float(currentUser.carbToday!)/Float(currentUser.carbCount!)
        cell.carbsProgress.setProgress(progress, animated: true)
        if (progress >= 1)
        {
            currentUser.client.updatePoints(d: "goals")
        }
        progress = Float(currentUser.fatToday!)/Float(currentUser.fatCount!)
        cell.fatsProgress.setProgress(progress, animated: true)
        if (progress >= 1)
        {
            currentUser.client.updatePoints(d: "goals")
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMeal" {
            let selectedIndex: IndexPath = sender as! IndexPath
            if let vc = segue.destination as? UINavigationController{
                if let nextView: MealView2Controller = vc.childViewControllers[0] as? MealView2Controller {
                    nextView.recievedItem = historyMealLog[selectedIndex.row]
                    nextView.isFavorite = currentUser.checkFavorite(itemId: historyMealLog[selectedIndex.row].itemId)
                    print(selectedIndex.row)
                }
            }
            
        }else if segue.identifier == "showFavoriteMeal" {
            let selectedIndex: IndexPath = sender as! IndexPath
            if let vc = segue.destination as? UINavigationController{
                if let nextView: MealView2Controller = vc.childViewControllers[0] as? MealView2Controller {
                    nextView.recievedItem = favoritesMealLog[selectedIndex.row]
                    nextView.isFavorite = currentUser.checkFavorite(itemId: favoritesMealLog[selectedIndex.row].itemId)
                    print(selectedIndex.row)
                }
            }
            
        }
    }
    
    func toSearch() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func showDetailsMenu(sender: DailyGoalProgressCell) {
        
        let myActionSheet = UIAlertController(title: "What would you like to do?", message: nil, preferredStyle: .actionSheet)
        
        let viewHistoryAction = UIAlertAction(title: "View Goal History", style: .default){ (ACTION) in
        
            print("go to goal history")
            
        }
        
        let goalAction = UIAlertAction(title: "Manually Adjust Macro Goal", style: .default){ (ACTION) in
            print("macro change button tapped")
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (ACTION) in
            print("cancel button tapped")
            
        }
        
        myActionSheet.addAction(viewHistoryAction)
        myActionSheet.addAction(goalAction)
        myActionSheet.addAction(cancelAction)
        
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    func tapped(sender: FoodCollectionCell) {
        print("Cell at row \(sender.tag)")
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        performSegue(withIdentifier: "showFavoriteMeal", sender: indexPath)
    }
    
}
