//
//  User.swift
//  MacroManager
//
//  Created by Alex Schultz on 1/19/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation

class User {
    var age: Int!
    var email: String!
    var goal: Int!
    var height: String!
    var name: String!
    var password: String!
    var weight: Int!
    
    var proteinCount: Int!
    var carbCount: Int!
    var fatCount: Int!
    
    var mealLog = [NixItem]() // meal history
    var favoriteLog = [NixItem]() // favorite meal list
    
    init() {
        // TEMP DUMMY USER INFO
        name = "Aaron Edwards"
        age = 24
        email = "aaronedwards@gmail.com"
        password = "passwordLOL"
        goal = 1
        height = "5' 11\""
        weight = 167
        proteinCount = 211
        carbCount = 316
        fatCount = 78
        
    }
    
    func addMealToFavorite(mealEaten: NixItem)
    {
        favoriteLog.append(mealEaten)
        
    }
    
    func removeMealFromFavorite(mealEaten: NixItem)
    {
        for index in 0...favoriteLog.count{
            if favoriteLog[index].itemId == mealEaten.itemId{
                favoriteLog.remove(at: index)
                break
            }
        }
    }
    
    func checkFavorite(itemId: String) -> Bool{
        
        var result = false
        
        if(favoriteLog.count == 0){
            result = false
        }else{
            
            for index in 0...favoriteLog.count - 1{
                if favoriteLog[index].itemId == itemId{
                    result = true
                }
            }
        }
        
        return result
    }
    
    func addMealToLog(mealEaten: NixItem) {
        mealLog.append(mealEaten)
        proteinCount = proteinCount - Int(mealEaten.proteins!)
        carbCount = carbCount - Int(mealEaten.carbs!)
        fatCount = fatCount - Int(mealEaten.fats!)
        print("prot: \(proteinCount), carb: \(carbCount), fat: \(fatCount)")
    }
    
}
