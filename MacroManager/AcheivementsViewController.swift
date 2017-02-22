//
//  AcheivementsViewController.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/16/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit

class AcheivementsViewController: UIViewController {
    
    var client:AchievementSystem = AchievementSystem()
    
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
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0)
        
        self.totalLbl.text = String(client.getTotal())
        
        var a = client.getAchievement(num: 0)
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
