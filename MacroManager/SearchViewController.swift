//
//  SearchViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/16/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit

class NixItemViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var proteinsLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
}


class SearchViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet var resultsTableView: UITableView!
    
    var foodSearchResults:Array<NixItem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.red
        
        performSearch(searchText: "tacos")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            self.resultsTableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodSearchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! NixItemViewCell
        let item = self.foodSearchResults[indexPath.row]
        
        cell.nameLabel.text = item.itemName
        cell.descriptionLabel.text = item.itemDescription
        
        if let fats = item.fats {
            cell.fatsLabel.text = "Fats: \(fats)"
        } else {
            cell.fatsLabel.text = "Fats: N/A"
        }
        
        if let proteins = item.proteins {
            cell.proteinsLabel.text = "Protein: \(proteins)"
        } else {
            cell.proteinsLabel.text = "Protein: N/A"
        }
        
        if let carbs = item.carbs {
            cell.carbsLabel.text = "Carbs: \(carbs)"
        } else {
            cell.carbsLabel.text = "Carbs: N/A"
        }
        
        return cell
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
