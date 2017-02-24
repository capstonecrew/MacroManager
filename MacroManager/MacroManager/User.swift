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
    var goal: String!
    var height: String!
    var name: String!
    var password: String!
    var weight: Int!
    var proteinCount: Int!
    var carbCount: Int!
    var fatCount: Int!
    var gender: String!
    var activityLevel: String!
    var calorieCount: Double!
    var proteinToday: Int!
    var carbToday: Int!
    var fatToday: Int!
    
    var mealLog = [NixItem]() // meal history
    var favoriteLog = [NixItem]() // favorite meal list
    var favoriteImage = [String]() // favorite meal list
    var customMealList = [NixItem]() // custom meals
    
    init() {
        // TEMP DUMMY USER INFO
        name = "Aaron Edwards"
        gender = "male"
        age = 24
        email = "aaronedwards@gmail.com"
        password = "passwordLOL"
        goal = "Maintain"
        activityLevel = "heavy"
        height = "5' 11\""
        weight = 167
        proteinCount = 211
        carbCount = 316
        fatCount = 78
        proteinToday = 0
        carbToday = 0
        fatToday = 0
        
    }
    
    init(name: String!, age: Int!, gender: String!, height: String!, weight: Int!, activityLevel: String!, goal: String!) {
        self.name = name
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.activityLevel = activityLevel
        self.goal = goal

        proteinCount = 211
        carbCount = 316
        fatCount = 78
        proteinToday = 0
        carbToday = 0
        fatToday = 0

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
    
    
    
    

    // sets daily macronutrients (protein, carb, fat)
    
    func macronutrientCalc()
    {
        var macros = (protein: 0.0, carb: 0.0, fat: 0.0)
        
        if goal == "Gain Muscle"
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
        
     
        proteinCount = Int(macros.protein)
        carbCount = Int(macros.carb)
        fatCount = Int(macros.fat)

    }
    
    
    
    
    // returns final calorie count for user
    
    func calorieCalc()
    {
        var temp : Double = 0
        var heightFeetInch: [String] = height.components(separatedBy: "' ")
        var Feet: String = heightFeetInch [0]
        var tempInch: String = heightFeetInch [1]
        
        var Inches: [String] = tempInch.components(separatedBy: "\"")
        var Inch: String = Inches[0]
        
        var FeetToInch = Double(Feet)! * 12.0
        var convertedHeight = FeetToInch + Double(Inch)!
        
        
        if gender == "male"
        {
            temp = 66 + (6.2 * Double(weight))
            temp = temp + (12.7 * convertedHeight) - (6.76 * Double(age))
            calorieCount = activityLvl(bmr: temp)
        }
            
        else
        {
            
            temp = 655.1 + (4.35 * Double(weight))
            temp = temp + (4.7 * convertedHeight) - (4.7 * Double(age))
            calorieCount = activityLvl(bmr: temp)

        }
        
    }
    
    
    
    // returns daily calorie count with activity level considered
    
    func activityLvl (bmr : Double) -> Double
    {
        var calorie : Double = 0
        
        if activityLevel == "Little to None"
        {
            calorie = bmr * 1.2
        }
        else if activityLevel == "Light"
        {
            calorie = bmr * 1.375

        }
        else if activityLevel == "Moderate"
        {
            calorie = bmr * 1.55
        }
        else if activityLevel == "Heavy"
        {
            calorie = bmr * 1.725
        }
        else
        {
            calorie = bmr * 1.9
        }

        return calorie
        
    }
    

    
    
    func addMealToLog(mealEaten: NixItem) {
        mealLog.append(mealEaten)
        proteinToday = proteinToday + Int(mealEaten.proteins!)
        carbToday = carbToday + Int(mealEaten.carbs!)
        fatToday = fatToday + Int(mealEaten.fats!)
        print("prot: \(proteinToday), carb: \(carbToday), fat: \(fatToday)")
    }
    
}
