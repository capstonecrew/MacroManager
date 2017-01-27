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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var currentSearch = ""
    var lastLoadedPage = 0
    var foodSearchResults:Array<NixItem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performSearch (searchText: String, page: Int) {
        NixApiManager.search(query: searchText, page: page) { response in
            for item in response.value! {
                print(item.toString())
                //Fill table view
                self.foodSearchResults.append(item)
            }
            
            // Refresh table view after new data
            self.resultsTableView.reloadData()
        }
    }
    
    // Search bar methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        if let text = searchBar.text {
            currentSearch = text
            lastLoadedPage = 0
            foodSearchResults.removeAll()
            performSearch(searchText: currentSearch, page: lastLoadedPage)
            
            // Scroll to top
            if let indexPath = resultsTableView.indexPathForRow(at: CGPoint(x: 0, y: 0)) {
                resultsTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            }
        }
    }
    
    //TODO: someone fix this to keep search bar
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // get the table and search bar bounds
        let tableBounds = self.resultsTableView.bounds.origin
        let searchBarFrameSize = self.searchBar.frame.size
        
        // make sure the search bar stays at the table's original x and y as the content moves
        self.searchBar.frame = CGRect(origin: tableBounds, size: searchBarFrameSize)
    }
    
    // Table view methods
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = foodSearchResults.count - 1
        
        if indexPath.row == lastElement - 5 {
            // Add another page of search results
            lastLoadedPage += 1
            performSearch(searchText: currentSearch, page: lastLoadedPage)
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
    
    func hideKeyboard(){
        
        view.endEditing(true)
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
