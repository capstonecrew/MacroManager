//
//  AcheivementsViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/16/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit

class AcheivementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

     var currentAchievements: [achievement] = []
    
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

        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        self.tableView.register(UINib(nibName: "AchievementProgressCell", bundle: nil), forCellReuseIdentifier: "achievementProgressCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
       
        
       /*
        self.totalLbl.text = String(client.getTotal())
        
       
        
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
       
        var temp: [achievement] = []
        currentAchievements = temp
        currentAchievements.append(currentUser.client.getAchievement(num: 0))
        currentAchievements.append(currentUser.client.getAchievement(num: 1))
        currentAchievements.append(currentUser.client.getAchievement(num: 2))
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAchievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "achievementProgressCell") as! AchievementProgressCell
       // cell.titleLbl.text = currentUser.client.achievements[indexPath.row].getName()
       cell.titleLbl.text = self.currentAchievements[indexPath.row].getName()
        cell.pointValueLbl.text = String(self.currentAchievements[indexPath.row].getReward())
        cell.completionRatioLbl.text = "\(self.currentAchievements[indexPath.row].getPoints()) / \(self.currentAchievements[indexPath.row].getProgress())"
        var progress = Float(self.currentAchievements[indexPath.row].getPoints())/Float(self.currentAchievements[indexPath.row].getProgress())
        cell.progressView.setProgress(progress, animated: true)
        
        /*
         @IBOutlet weak var pointValueLbl: UILabel!
         @IBOutlet weak var titleLbl: UILabel!
         @IBOutlet weak var progressView: UIProgressView!
         @IBOutlet weak var completionRatioLbl: UILabel!
         var progress = Float(currentUser.proteinToday!)/Float(currentUser.proteinCount!)
         print(progress)
         cell.proteinProgress.setProgress(progress, animated: true)
 
 */
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 63.0
        
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
