//
//  DashboardViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit
import Charts

class DashboardViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, FoodCollectionCellDelegate {

    var nutrients = ["Proteins", "Carbohydrates", "Fats"]
    var unitsSold = [1.0, 2.0, 3.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        tableView.register(UINib(nibName: "WelcomeUserCell", bundle: nil), forCellReuseIdentifier: "welcomeUserCell")
        tableView.register(UINib(nibName: "DailyGoalProgressCell", bundle: nil), forCellReuseIdentifier: "dailyGoalProgressCell")
        tableView.register(UINib(nibName: "SuggestedFoodsCell", bundle: nil), forCellReuseIdentifier: "suggestedFoodsCell")

        self.navigationItem.title = "macro manager"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Coolvetica", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(barChart: BarChartView, dataPoints: [String], values: [Double]) {
        
        barChart.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.colors = ChartColorTemplates.vordiplom()
        let chartData = BarChartData(dataSet: chartDataSet)
        //chartData.value
        barChart.data = chartData
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if(indexPath.row == 0){
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "suggestedFoodsCell") as! SuggestedFoodsCell
            
            cell.foodsCollectionView.delegate = self
            cell.foodsCollectionView.dataSource = self
            cell.foodsCollectionView.register(UINib(nibName: "FoodCollectionCell", bundle: nil), forCellWithReuseIdentifier: "foodCollectionCell")
        
            cell.foodsCollectionView.collectionViewLayout.accessibilityScroll(.right)
            
            return cell
            
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "dailyGoalProgressCell") as! DailyGoalProgressCell
            setChart(barChart: cell.progressChart, dataPoints: nutrients, values: unitsSold)

            return cell
        }else if(indexPath.row == 2){
            let cell = UITableViewCell()
            cell.detailTextLabel?.text = "History"
            return cell
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            
            return 130.0
            
        }else if(indexPath.row == 1){
            
            return 234.0
        }
        
        return 39.0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCollectionCell", for: indexPath) as!FoodCollectionCell
        cell.tag = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected indexPath: \(indexPath.section), \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func tapped(sender: FoodCollectionCell) {
        print("Cell at row \(sender.tag)")
    }
    
}
