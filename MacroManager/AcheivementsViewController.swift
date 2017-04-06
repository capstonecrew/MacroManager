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

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
       /*
 
 HEY AARON AND MARK
         this is where I stopped. We were going to try to pull the # of achievements from 'current', and put them in achievements[] for the tableview row size, then compare those #s to the actual achievements using their # as the index. 
         
 */
        
        currentUser.client.getAchievementList(completion: {(results) in
            
            for result in results{
                
                print(result.getName())
            }
            
            self.achievements = results
            print(self.achievements.count)
            self.tableView.reloadData()
        
        })
        
//        achievements.append(currentUser.client.getAchievement(num: 0))
//        achievements.append(currentUser.client.getAchievement(num: 1))
//        achievements.append(currentUser.client.getAchievement(num: 2))
//        achievements.append(currentUser.client.getAchievement(num: 3))
//        achievements.append(currentUser.client.getAchievement(num: 4))
        /*
         self.totalLbl.text = String(client.getTotal())
         
         var a =
         var b = client.getAchievement(num: 1)
         var c = client.getAchievement(num: 2)
         
         self.progress1.setProgress(Float(a.getPoints()), animated: true)
         self.progress2.setProgress(Float(b.getPoints()), animated: true)
         self.progress3.setProgress(Float(c.getPoints()), animated: true)
         
         self.progressReward1.text = String(a.getReward())
         self.progressReward2.text = String(b.getReward())
         self.progressReward3.text = String(c.getReward())
         
         self.progressLbl1.text = a.getName()
         self.progressLbl2.text = b.getName()
         self.progressLbl3.text = c.getName()
         */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        var temp: [achievement] = []
//        achievements = temp
//        achievements.append(currentUser.client.getAchievement(num: 0))
//        achievements.append(currentUser.client.getAchievement(num: 1))
//        achievements.append(currentUser.client.getAchievement(num: 2))
//        achievements.append(currentUser.client.getAchievement(num: 3))
//        achievements.append(currentUser.client.getAchievement(num: 4))
        
        currentUser.client.getAchievementList{(result) in
            
            self.achievements = result
            self.tableView.reloadData()
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
           numRows = 1
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "acheivementHeaderCell") as! AcheivementHeaderCell
            cell.totalPointsLbl.text = "\(currentUser.client.getTotal())"
            actualCell = cell
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
            height = 97.0
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
