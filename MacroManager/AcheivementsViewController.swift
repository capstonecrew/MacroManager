//
//  AcheivementsViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/16/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit
import Firebase
class AcheivementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var achievements: [achievement] = []
    var currentAchievements : [Int] = []
    var hasRewardHistory = false
    var lastAchievementReward: Int!
    var lastAchievementName: String!
    /*
     @IBOutlet weak var totalLbl: UILabel!
     @IBOutlet weak var progress1: UIProgressView!
     @IBOutlet weak var progress2: UIProgressView!
     @IBOutlet weak var progress3: UIProgressView!
     @IBOutlet weak var progressLbl1: UILabel!
     @IBOutlet weak var progressLbl2: UILabel!
     @IBOutlet weak var progressLbl3: UILabel!
     @IBOutlet weak var progressReward1: UILabel!
     @IBOutlet weak var progressReward2: UILabel!
     @IBOutlet weak var progressReward3: UILabel!
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = "Achievements"

        navigationController?.navigationBar.barTintColor = UIColor(red:0.29, green:0.55, blue:0.90, alpha:1.0)
        navigationController?.navigationBar.isTranslucent = false

        self.tableView.register(UINib(nibName: "AchievementProgressCell", bundle: nil), forCellReuseIdentifier: "achievementProgressCell")
        self.tableView.register(UINib(nibName: "AcheivementHeaderCell", bundle: nil), forCellReuseIdentifier: "acheivementHeaderCell")
        self.tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "headerCell")
        self.tableView.register(UINib(nibName: "LastAchievementCell", bundle: nil), forCellReuseIdentifier: "lastAchievementCell")

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .singleLine
        
        /*
        historyMealLog = [GenericFoodItem]()
        let userID = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        let historyRef = ref.child("history").child(userID!)

         lookupGroup.enter()
         
         historyRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
         
         for item in snapshot.children{
         let historyItem = GenericFoodItem.init(snap: item as! FIRDataSnapshot)
         self.historyMealLog.append(historyItem)
         }
         
         lookupGroup.leave()
         }
        */
        
        var achievementLog = [achievement]()
        let userID = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        let currentRef = ref.child("achievements").child(userID!).child("currentList")
        let achievementListRef = ref.child("achievements").child(userID!).child("achievementList")
        let lookupGroup = DispatchGroup()
        
        currentUser.client.getAchievementList(completion: {(results) in
            
            for result in results{
                
                print(result.getName())
            }
            
            self.achievements = results
            
            currentUser.client.getLastCompleted(completion: {(name, reward) in
                
                if reward != 0{
                    
                    self.hasRewardHistory = true
                    self.lastAchievementReward = reward
                    self.lastAchievementName = name
                }
                
                self.tableView.reloadData()
                
            })
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        currentUser.client.getAchievementList{(result) in
            
            self.achievements = result
            currentUser.client.getLastCompleted(completion: {(name, reward) in
                
                if reward != 0{
                    
                    self.hasRewardHistory = true
                    self.lastAchievementReward = reward
                    self.lastAchievementName = name
                }

                self.tableView.reloadData()
                
            })
            
        }
//        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numRows: Int = 0
        
        if(section == 0){
           
            if hasRewardHistory{
                numRows = 2
            }else{
                numRows = 1
            }
        }else{
            numRows = achievements.count
        }
        
        return numRows
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell

        
        if(section == 0){
            cell.headerLbl.text = "Overview"
        }else{
            cell.headerLbl.text = "In Progress"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var actualCell = UITableViewCell()
        
        if(indexPath.section == 0){
            
            if indexPath.row == 0{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "acheivementHeaderCell") as! AcheivementHeaderCell
                //cell.totalPointsLbl.text = "\(currentUser.client.getTotal())"
                let totalPoints = currentUser.client.getTotal(completion: {(result) in
                    print("result")
                    print(result)
                    cell.totalPointsLbl.text = String(result)
                })
                
                actualCell = cell
                
            }else{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "lastAchievementCell") as! LastAchievementCell
                cell.nameLbl.text = self.lastAchievementName
                cell.rewardLbl.text = "\(String(describing: self.lastAchievementReward!)) pts"
                
                actualCell = cell
            }
            
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "achievementProgressCell") as! AchievementProgressCell
            cell.titleLbl.text = achievements[indexPath.row].getName()
            cell.pointValueLbl.text = String(achievements[indexPath.row].getReward())
            cell.completionRatioLbl.text = "\(achievements[indexPath.row].getPoints()) / \(achievements[indexPath.row].getProgress())"
            var progress = Float(achievements[indexPath.row].getPoints()) / Float(achievements[indexPath.row].getProgress())
            
            cell.progressView.setProgress(progress,animated:true)
            actualCell = cell
        }
        
        
        
        return actualCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 63.0
        
        switch indexPath.section {
        case 0:
            
            if indexPath.row == 0{
                height = 97.0
            }else{
                height = 70.0
            }
            
        case 1:
            height = 76.0
        default:
            break
        }
        
        return height
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
