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
    var gender: String!
    var activityLevel: String!
   // var calorieCount: Double!
    
    var proteinToday: Int!
    var carbToday: Int!
    var fatToday: Int!
    
    var mealLog = [NixItem]() // meal history
    var favoriteLog = [NixItem]() // favorite meal list
    var customMealList = [NixItem]() // custom meals
    
    
    
    init() {
        // TEMP DUMMY USER INFO
        name = "Aaron Edwards"
      //  gender = "male"
        age = 24
        email = "aaronedwards@gmail.com"
        password = "passwordLOL"
        goal = 1
        height = "5' 11\""
        weight = 167
        proteinCount = 211
        carbCount = 316
        fatCount = 78
        proteinToday = 0
        carbToday = 0
        fatToday = 0
        
    }
    
    init(name: String!, age: Int!, gender: String!, height: String!, weight: Int!, activityLevel: String!) {
        self.name = name
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.activityLevel = activityLevel
    }
    
    func toAnyObject() -> [String: Any] {
        return ["name": name, "age": age, "gender": gender, "height": height, "weight": weight, "activityLevel": activityLevel]
    }
    
    
    func addMealToFavorite(mealEaten: NixItem)
    {
        favoriteLog.append(mealEaten)
        
    }
    
    
    // add custom meal
    func addCustomMeal(itenName: String, itemDescription: String?, fats: Double?, proteins: Double?, carbs: Double?) {
        let custNix: NixItem! = NixItem(itemName: itenName, itemId: "custom", itemDescription: itemDescription, fats: fats, proteins: proteins, carbs: carbs)
        customMealList.append(custNix) // add to custom meal log
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
    
    
    
    
/*
    // returns a tuple of daily macronutrients (protein, carb, fat)
    
    func macronutrientCalc(goal: String) -> (protein: Double, carb: Double, fat: Double)
    {
        var macros = (protein: 0.0, carb: 0.0, fat: 0.0)
        
        if goal == "Gain"
        {
           macros.protein = (calorieCount * 0.30) / 4.0
           macros.carb = (calorieCount * 0.50) / 4.0
           macros.fat = (calorieCount * 0.20) / 9.0
        }
        else if goal == "Maintain"
        {
           macros.protein = (calorieCount * 0.30) / 4.0
           macros.carb = (calorieCount * 0.40) / 4.0
           macros.fat = (calorieCount * 0.30) / 9.0
        }
        else
        {
           macros.protein = (calorieCount * 0.45) / 4.0
           macros.carb = (calorieCount * 0.20) / 4.0
           macros.fat = (calorieCount * 0.35) / 9.0
        }
        
        return macros
    }
    
    
    
    
    // returns final calorie count for user
    
    func calorieCalc(activity: String, bmr: Double, gender: String, age: Double, height: Double, weight: Double)
    {
        
        if gender == "male"
        {
            calorieCount = 66 + (6.2 * weight) + (12.7 * height) - (6.76 * age)
            calorieCount = activityLvl(activity: activity, bmr: calorieCount)
        }
            
        else
        {
            
            calorieCount = 655.1 + (4.35 * weight) + (4.7 * height) - (4.7 * age)
            calorieCount = activityLvl(activity: activity, bmr: calorieCount)

        }
        
    }
    
    
    
    // returns daily calorie count with activity level considered
    
    func activityLvl (activity: String, bmr : Double) -> Double
    {
        var calorie : Double = 0
        
        if activity == "little to none"
        {
            calorie = bmr * 1.2
        }
        else if activity == "light"
        {
            calorie = bmr * 1.375
        }
        else if activity == "moderate"
        {
            calorie = bmr * 1.55
        }
        else if activity == "heavy"
        {
            calorie = bmr * 1.725
        }
        else
        {
            calorie = bmr * 1.9
        }
        
        return calorie
        
    }
    
*/
    
    
    func addMealToLog(mealEaten: NixItem) {
        mealLog.append(mealEaten)
        proteinToday = proteinToday + Int(mealEaten.proteins!)
        carbToday = carbToday + Int(mealEaten.carbs!)
        fatToday = fatToday + Int(mealEaten.fats!)
        print("prot: \(proteinToday), carb: \(carbToday), fat: \(fatToday)")
    }
    
}
