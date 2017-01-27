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
    
    var foodSearchResults:Array<NixItem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    func performSearch (searchText: String) {
        foodSearchResults.removeAll()
        
        NixApiManager.search(query: searchText, page: 0) { response in
            for item in response.value! {
                print(item.toString())
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "meal", for: indexPath) as! SearchTableViewCell
        cell.mealNameLabel.text = "test"
        
        let item = self.foodSearchResults[indexPath.row]
        
        cell.mealNameLabel.text = item.itemName
        cell.descriptionLabel.text = item.itemDescription
        
        if let fats = item.fats {
            cell.fatLabel.text = "Fats: \(fats)"
        } else {
            cell.fatLabel.text = "Fats: N/A"
        }
        
        if let proteins = item.proteins {
            cell.proteinLabel.text = "Protein: \(proteins)"
        } else {
            cell.proteinLabel.text = "Protein: N/A"
        }
        
        if let carbs = item.carbs {
            cell.carbsLabel.text = "Carbs: \(carbs)"
        } else {
            cell.carbsLabel.text = "Carbs: N/A"
        }
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMeal" {
            let selectedIndex: IndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
            if let nextView: MealView2Controller = segue.destination as? MealView2Controller {
                nextView.recievedNix = foodSearchResults[selectedIndex.row]
                print(selectedIndex.row)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            performSearch(searchText: text)
        }    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            performSearch(searchText: text)
        }
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
