//
//  AchievementSystem.swift
//  MacroManager
//
//  Created by Mark on 2/21/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation
class AchievementSystem{
    
    //first call
    var setup: Bool = true
    //users overall score
    var totalPoints = 0
    //current 3 achievement indexes
    var current: [Int] = []
    //all achievements
    var achievements: [achievement] = []
    //initialize 8 achivement objects
    init(){
        if(setup){
            
            /*
            IMPLEMENTED
             weight[]
             eatmeal[X]
             search[X]
             addMeal[]
             goals[X]
             addFav[X]
             eatFav[]
             udpate[X]
 
 
 
        */
            var newAchievement = achievement(n: "5lb Weight Goal",p: 0,pro: 1, d: "weight", r: 50)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 10 Meals",p: 0,pro: 10, d: "eatMeal", r: 10)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Perform 10 Meal Searches",p: 0,pro: 10, d: "search", r: 10)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add 5 Custom Meals",p: 0,pro: 5, d: "customMeal", r: 20)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "3 Daily Goals Met",p: 0,pro: 3, d: "goals", r: 30)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Add 5 Favorite Meals",p: 0,pro: 5, d: "addFav", r: 20)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Eat 5 Favorite Meals",p: 0,pro: 5, d: "eatFav", r: 20)
            achievements.append(newAchievement)
            newAchievement = achievement(n: "Update Weight",p: 0,pro: 1, d: "update", r: 10)
            achievements.append(newAchievement)
            
            //randomly assign 3 achievements
            for i in 0...2{
                if i == 0{
                    current.append(Int(arc4random_uniform(8)))
                }
                else{
                    var randomInt = current[0]
                    while(current.contains(randomInt)){
                        randomInt = Int(arc4random_uniform(8))
                    }
                    current.append(randomInt)
                }
            }
        }
        setup = false
    }
    
    //generate new achievement
    func newAchievement(name: String) -> achievement{
        var randomInt = current[0]
        while(current.contains(randomInt)){
            randomInt = Int(arc4random_uniform(8))
        }
        return achievements[randomInt]
    }
    
    //update progress
    func updatePoints(d: String){
        //if in current
        for x in current{
            if achievements[x].des == d{
                achievements[x].points += 1
                if(achievements[x].points == achievements[x].progress){
                    achievements[x].points = 0
                    updateTotal(points: achievements[x].reward)
                    
                    //get new feature
                    finishedAchievement(num: x)
                    
                    
                }
            }
        }
    }
    
    //add new achievement to current
    func finishedAchievement(num: Int){
        var randomInt = current[0]
        while(current.contains(randomInt) || randomInt == num){
            randomInt = Int(arc4random_uniform(8))
        }
        for a in 0...2{
            if(num == current[a]){
                current[a] = randomInt
            }
        }
    }
    
    //get initial achievements
    func getAchievement(num: Int) -> achievement{
        return achievements[current[num]]
    }
    
    //update total score
    func updateTotal(points: Int){
        self.totalPoints += points
    }
    
    //get total
    func getTotal() -> Int{
        return self.totalPoints
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
    
}
