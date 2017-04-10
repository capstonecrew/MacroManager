//
//  AchievementSystem.swift
//  MacroManager
//
//  Created by Mark on 2/21/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation
import Firebase
class AchievementSystem{
    
    //last completed achievement
    var lastCompleted = achievement(n: "name",p: 0,pro: 0, d: "des", r: 0)
    
    //first call
    var setup: Bool = true
    
    //users overall score
    var totalPoints = 0
    
    //current 5 achievement indexes
    var current: [Int] = []
    
    //current 5 achievement types
    var types: [String] = []
    
    //all achievements
    var achievements: [achievement] = []
    var currentAchievements: [achievement] = []
    
    //initialize 28 achivement objects
    init(){
        if(setup){
            
            /*
            IMPLEMENTED
             weight[X]
             eatmeal[X]
             search[X]
             customMeal[x]
             goals[X]
             addFav[X]
             eatFav[x]
             udpate[X]
 
 
 
        */
            var newAchievement = achievement(n: "3 lb Weight Goal",p: 0,pro: 3, d: "weight", r: 50)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "5 lb Weight Goal",p: 0,pro: 5, d: "weight", r: 75)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "8 lb Weight Goal",p: 0,pro: 8, d: "weight", r: 100)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 5 Meals",p: 0,pro: 5, d: "eatMeal", r: 10)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 10 Meals",p: 0,pro: 10, d: "eatMeal", r: 20)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 15 Meals",p: 0,pro: 15, d: "eatMeal", r: 30)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 20 Meals",p: 0,pro: 20, d: "eatMeal", r: 40)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 25 Meals",p: 0,pro: 25, d: "eatMeal", r: 50)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 50 Meals",p: 0,pro: 50, d: "eatMeal", r: 150)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Perform 5 Meal Searches",p: 0,pro: 5, d: "search", r: 5)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Perform 10 Meal Searches",p: 0,pro: 10, d: "search", r: 10)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Perform 25 Meal Searches",p: 0,pro: 25, d: "search", r: 50)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Perform 50 Meal Searches",p: 0,pro: 50, d: "search", r: 100)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Perform 100 Meal Searches",p: 0,pro: 100, d: "search", r: 250)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add Custom Meal",p: 0,pro: 1, d: "customMeal", r: 5)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add 5 Custom Meals",p: 0,pro: 5, d: "customMeal", r: 50)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add 10 Custom Meals",p: 0,pro: 10, d: "customMeal", r: 150)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Daily Goal Met",p: 0,pro: 1, d: "goals", r: 10)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "3 Daily Goals Met",p: 0,pro: 3, d: "goals", r: 30)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "5 Daily Goals Met",p: 0,pro: 5, d: "goals", r: 50)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add Favorite Meal",p: 0,pro: 1, d: "addFav", r: 5)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add 5 Favorite Meals",p: 0,pro: 5, d: "addFav", r: 20)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add 10 Favorite Meals",p: 0,pro: 10, d: "addFav", r: 50)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add 25 Favorite Meals",p: 0,pro: 25, d: "addFav", r: 100)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat Favorite Meal",p: 0,pro: 1, d: "eatFav", r: 5)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 5 Favorite Meals",p: 0,pro: 5, d: "eatFav", r: 20)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 10 Favorite Meals",p: 0,pro: 10, d: "eatFav", r: 50)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Update Weight",p: 0,pro: 1, d: "update", r: 10)
            achievements.append(newAchievement)
            
            //randomly assign 5 achievements
            for i in 0...4{
                if i == 0{
                    let rand = Int(arc4random_uniform(28))
                    types.append(achievements[rand].des)
                    current.append(rand)
                }
                else{
                    var randomInt = current[0]
                    while(current.contains(randomInt) || types.contains(achievements[randomInt].des)){
                        randomInt = Int(arc4random_uniform(28))
                    }
                    current.append(randomInt)
                    types.append(achievements[randomInt].des)
                }
            }
        }
        setup = false
    }
    
    /*
    //generate new achievement
    func newAchievement(name: String) -> achievement{
        var randomInt = current[0]
        while(current.contains(randomInt) || types.contains(achievements[randomInt].des)){
            randomInt = Int(arc4random_uniform(28))
        }
        return achievements[randomInt]
    }
    */
    
    //update progress
    func updatePoints(d: String){
        /*
        //if in current
        for x in current{
            if achievements[x].des == d{
                achievements[x].points += 1
                if(achievements[x].points == achievements[x].progress){
                    achievements[x].points = 0
                    updateTotal(points: achievements[x].reward)
                    
                    //save last completed achievement
                    lastCompleted = achievements[x]
                    
                    //get new feature
                    finishedAchievement(num: x)
                    
                    
                }
            }
        }
        */
        var values = [Int]()
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let allRef = FIRDatabase.database().reference().child("achievements").child(uid!).child("achievementList")
        let currentRef = FIRDatabase.database().reference().child("achievements").child(uid!).child("currentList")
        
        
        currentRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            for a in snapshot.children{
                
                let v = a as! FIRDataSnapshot
                values.append(v.value as! Int)
                
            }
            
            self.current = values
            //values.sort()
            
            allRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
                
                for a in snapshot.children{
                    
                    let snap = a as! FIRDataSnapshot
                    let key = snap.key
                    let ii = Int(key)
                    
                    
                    if values.contains(ii!){
                        
                        let v = achievement(snap: snap)
                        //if this current achievement has d:String, update points
                        if self.achievements[ii!].des == d{
                            
                            let pointsRef = FIRDatabase.database().reference().child("achievements").child(uid!).child("achievementList").child(String(ii!))
                            
                            let currentPoints = v.points + 1

                            pointsRef.updateChildValues(["points" : currentPoints])
                            
                            if(currentPoints == v.progress){
                                //get new achievement
                                self.finishedAchievement(num: ii!)
                                
                                //reset points to 0
                                pointsRef.updateChildValues(["points" : 0])
                                
                                //save to lastCompleted
                                let lastRef = FIRDatabase.database().reference().child("achievements").child(uid!).child("lastCompleted")
                                lastRef.setValue(v.toAnyObject())
                                
                                self.updateTotal(points: v.reward)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //add new achievement to current
    func finishedAchievement(num: Int){
        
        //update types
        for a in 0...4{
            self.types[a] = self.achievements[current[a]].des
        }
        
        var randomInt = current[0]
        while(current.contains(randomInt) || randomInt == num || types.contains(achievements[randomInt].des)){
            randomInt = Int(arc4random_uniform(28))
        }
        for a in 0...4{
            if(num == current[a]){
                
                let uid = FIRAuth.auth()?.currentUser?.uid
                let currentRef = FIRDatabase.database().reference().child("achievements").child(uid!).child("currentList")
                currentRef.updateChildValues([String(a) : randomInt])
                /*
                current[a] = randomInt
                types[a] = achievements[randomInt].des
                */
            }
        }
        
        
        
        
    }
    
    //update weight goal
    func updateWeightGoal(oldW: Int, newW: Int){
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let currentRef = FIRDatabase.database().reference().child("achievements").child(uid!).child("currentList")
        var values = [Int]()
        types = [String]()
        
        currentRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            for a in snapshot.children{
                
                let v = a as! FIRDataSnapshot
                values.append(v.value as! Int)
                
            }
            self.current = values
            
            //update types
            for a in 0...4{
                self.types.append(self.achievements[self.current[a]].des)
            }
            
            if(self.types.contains("weight")){

                let ref = FIRDatabase.database().reference()
                let uid = FIRAuth.auth()?.currentUser?.uid
                var totalChange:Int = 0
                var goal:String = ""
                let goalRef = ref.child("users").child(uid!).child("goal")
                
                goalRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
                    //get goal
                    goal = snapshot.value! as! String
                    
                    if(goal == "Lose Fat"){
                        let loss = oldW - newW
                        if( loss > 0){
                            totalChange = loss
                            self.saveWeight(totalW: totalChange)
                        }
                        
                    }
                    else if (goal == "Gain Muscle"){
                        let gain = newW - oldW
                        if( gain > 0){
                            totalChange = gain
                            self.saveWeight(totalW: totalChange)
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
    //save weight
    func saveWeight(totalW: Int){
        
        let ref = FIRDatabase.database().reference()
        let uid = FIRAuth.auth()?.currentUser?.uid
        let weightRef = ref.child("achievements").child(uid!).child("weightChange")
        for a in 0...4{
            if(achievements[current[a]].des == "weight"){
                let pointRef = ref.child("achievements").child(uid!).child("achievementList").child(String(current[a])).child("points")
                let progressRef = ref.child("achievements").child(uid!).child("achievementList").child(String(current[a])).child("progress")
                let rewardRef = ref.child("achievements").child(uid!).child("achievementList").child(String(current[a])).child("reward")
                
                var _progress = 0
                var _points = 0
                
                pointRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
                    _points = snapshot.value as! Int
                }
                
                progressRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
                    _progress = snapshot.value as! Int
                    
                    if(_points + totalW >= _progress){
                        weightRef.setValue(0)
                        rewardRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
                            self.updateTotal(points: snapshot.value as! Int)
                        }
                        self.finishedAchievement(num: self.current[a])
                        pointRef.setValue(0)
                    }
                    else{
                        pointRef.setValue(totalW + _points)
                        weightRef.setValue(totalW + _points)
                    }
                    
                }

            }
        }
    }
    
    //get initial achievements
    func getAchievement(num: Int) -> achievement{
        return achievements[current[num]]
    }
    
    //update total score
    func updateTotal(points: Int){
        var totalPoints = points
        //self.totalPoints += points
        let ref = FIRDatabase.database().reference()
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let scoreRef = ref.child("achievements").child(uid!).child("totalScore")
        
        scoreRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            totalPoints += snapshot.value as! Int
            scoreRef.setValue(totalPoints)
        }
    }
    
    //get total
    func getTotal(completion: @escaping (Int)->()){
        //return self.totalPoints
        
        var currentTotal = 0
        
        let ref = FIRDatabase.database().reference()
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let scoreRef = ref.child("achievements").child(uid!).child("totalScore")
        
        scoreRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            currentTotal = snapshot.value as! Int
            completion(currentTotal)
        }
    }
    
    //returns default achievement for initial database setup
    func getDefaultAchievement() -> achievement{
        return lastCompleted
    }
    
    
    func getLastCompleted() -> achievement{
        
        //TODO
        //get last completed from Firebase
        
        return lastCompleted
    }
    
    func getAchievementList(completion: @escaping ([achievement])->()){
        
        var values = [Int]()
        var array = [achievement]()
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let allRef = FIRDatabase.database().reference().child("achievements").child(uid!).child("achievementList")
        let currentRef = FIRDatabase.database().reference().child("achievements").child(uid!).child("currentList")
        
        
        currentRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            for a in snapshot.children{
                
                let v = a as! FIRDataSnapshot
                values.append(v.value as! Int)
                
            }
            
            //values.sort()
            
            allRef.observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
                
                for a in snapshot.children{
                    
                    let snap = a as! FIRDataSnapshot
                    let key = snap.key
                    let index = Int(key)
                    
                    if values.contains(index!){
                        
                        let v = achievement(snap: snap)
                        array.append(v)
                        
                    }
                }
                
                completion(array)
            })
        }
    }
    
}

class achievement {
    
    fileprivate var name: String = ""
    fileprivate var points: Int = 0
    fileprivate var progress: Int = 0
    fileprivate var des: String = ""
    fileprivate var reward: Int = 0
    
    init (n: String, p: Int, pro: Int, d: String, r: Int){
        name = n
        points = p
        progress = pro
        des = d
        reward = r
    }
    init(snap: FIRDataSnapshot)
    {
       
       
        let value = snap.value as? NSDictionary
        if let n = value!["name"] as? String{
            self.name = n
            
        }
       if let i = value!["points"] as? Int
       {
        self.points = i
        }
        if let p = value!["progress"] as? Int
        {
            self.progress = p
        }
        if let description = value!["des"] as? String
        {
            self.des = description
        }
        if let r = value!["reward"] as? Int
        {
            self.reward = r
        }
    }
    internal func getName() -> String{
        return name
    }
    
    internal func getPoints() -> Int{
        return points
    }
    
    internal func getProgress() -> Int{
        return progress
    }
    
    internal func getDes() -> String{
        return des
    }
    internal func getReward() -> Int{
        return reward
    }
    func toAnyObject() -> [String: Any]{
        return ["name" : self.name, "points" : self.points, "progress":self.progress, "description": self.des, "reward": self.reward]
    }
    
}
