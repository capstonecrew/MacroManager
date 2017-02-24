//
//  DashboardViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit
import AlamofireImage

class DashboardViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, FoodCollectionCellDelegate, SuggestedFoodsCellDelegate {
    
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
        tableView.reloadData()
        
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
            numRows = currentUser.mealLog.count
        default:
            break
        }
        
        return numRows
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
                
                if(currentUser.favoriteLog.count != 0){
                    cell.addFavoriteBtn.isHidden = true
                }else{
                    cell.addFavoriteBtn.isHidden = false
                }
                
                cell.foodsCollectionView.collectionViewLayout.accessibilityScroll(.right)
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
                return cell
            }

        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailsCell") as! MealDetailsCell
            cell.accessoryLbl.isHidden = true
            cell.mainLbl.text = currentUser.mealLog[indexPath.row].itemName
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
        cell.foodLbl.text = currentUser.favoriteLog[indexPath.row].itemName
        cell.foodImageView.af_setImage(withURL: URL(string: currentUser.favoriteLog[indexPath.row].imageUrl!)! , placeholderImage: UIImage(named: "taco_Icon"), filter: CircleFilter())
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected indexPath: \(indexPath.section), \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentUser.favoriteLog.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func animateBarGraph(){
        print("animating bar graph")
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DailyGoalProgressCell
        
        var progress = Float(currentUser.proteinToday!)/Float(currentUser.proteinCount!)
        print(progress)
        cell.proteinProgress.setProgress(progress, animated: true)
        
        progress = Float(currentUser.carbToday!)/Float(currentUser.carbCount!)
        cell.carbsProgress.setProgress(progress, animated: true)
        
        progress = Float(currentUser.fatToday!)/Float(currentUser.fatCount!)
        cell.fatsProgress.setProgress(progress, animated: true)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMeal" {
            let selectedIndex: IndexPath = sender as! IndexPath
            if let vc = segue.destination as? UINavigationController{
                if let nextView: MealView2Controller = vc.childViewControllers[0] as? MealView2Controller {
                    nextView.recievedNix = currentUser.mealLog[selectedIndex.row]
                    nextView.isFavorite = currentUser.checkFavorite(itemId: currentUser.mealLog[selectedIndex.row].itemId)
                    print(selectedIndex.row)
                }
            }
            
        }else if segue.identifier == "showFavoriteMeal" {
            let selectedIndex: IndexPath = sender as! IndexPath
            if let vc = segue.destination as? UINavigationController{
                if let nextView: MealView2Controller = vc.childViewControllers[0] as? MealView2Controller {
                    nextView.recievedNix = currentUser.favoriteLog[selectedIndex.row]
                    nextView.isFavorite = currentUser.checkFavorite(itemId: currentUser.favoriteLog[selectedIndex.row].itemId)
                    print(selectedIndex.row)
                }
            }
            
        }
    }
    
    func toSearch() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func tapped(sender: FoodCollectionCell) {
        print("Cell at row \(sender.tag)")
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        performSegue(withIdentifier: "showFavoriteMeal", sender: indexPath)
    }
    
}
