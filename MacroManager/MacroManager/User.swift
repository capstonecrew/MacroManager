//
//  User.swift
//  MacroManager
//
//  Created by Alex Schultz on 1/19/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject {
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
    
    var mealLog = [GenericFoodItem]() // meal history
    var favoriteLog = [GenericFoodItem]() // favorite meal list
    var favoriteImage = [String]() // favorite meal list
    var customMealList = [GenericFoodItem]() // custom meals
    var client:AchievementSystem = AchievementSystem()
    
    override init() {
        super.init()
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
        
        print("dummy info used")
        
    }
    
    init(name: String!, age: Int!, gender: String!, height: String!, weight: Int!, activityLevel: String!, goal: String!) {
        super.init()
        self.name = name
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.activityLevel = activityLevel
        self.goal = goal
        self.proteinToday = 0
        self.carbToday = 0
        self.fatToday = 0
        
        self.calorieCalc()
        self.macronutrientCalc()
        
    }
    
    init(snap: FIRDataSnapshot) {
        super.init()
        
        let value = snap.value as? NSDictionary
        
        
        if let n = value!["name"] as? String{
            
            self.name = n
            
        }else{
            
            self.name = ""
        }
        
        if let a = value!["age"] as? Int{
            
            self.age = a
            
        }else{
            
            self.age = 0
        }
        
        if let g = value!["gender"] as? String{
            
            self.gender = g
            
        }else{
            
            self.gender = ""
            
        }
        
        if let h = value?["height"] as? String{
            
            self.height = h
            
        }else{
            
            self.height = ""
        }
        
        if let w = value?["weight"] as? Int{
            
            self.weight = w
            
        }else{
            
            self.weight = 0
        }
        
        if let activity = value?["activityLevel"] as? String{
            
            self.activityLevel = activity
            
        }else{
            
            self.activityLevel = ""
        }
        
        if let weightGoal = value?["goal"] as? String{
            
            self.goal = weightGoal
            
        }else{
            
            self.goal = ""
        }
        
        if let protein = value?["proteinToday"] as? Int{
            
            self.proteinToday = protein
            
        }else{
            
            self.proteinToday = 0
        }
        
        if let fat = value?["fatToday"] as? Int{
            
            self.fatToday = fat
            
        }else{
            
            self.fatToday = 0
        }
        
        if let carb = value?["carbToday"] as? Int{
            
            self.carbToday = carb
            
        }else{
            
            self.carbToday = 0
        }
        
        self.calorieCalc()
        self.macronutrientCalc()
        
        print("created user from FIRDatabase")
        
        
    }
    
    init(dict: [String: Any]) {
        super.init()
        
        let value = dict
        
        if let n = value["name"] as? String{
            
            self.name = n
            
        }else{
            
            self.name = ""
        }
        
        if let a = value["age"] as? Int{
            
            self.age = a
            
        }else{
            
            self.age = 0
        }
        
        if let g = value["gender"] as? String{
            
            self.gender = g
            
        }else{
            
            self.gender = ""
            
        }
        
        if let h = value["height"] as? String{
            
            self.height = h
            
        }else{
            
            self.height = ""
        }
        
        if let w = value["weight"] as? Int{
            
            self.weight = w
            
        }else{
            
            self.weight = 0
        }
        
        if let activity = value["activityLevel"] as? String{
            
            self.activityLevel = activity
            
        }else{
            
            self.activityLevel = ""
        }
        
        if let weightGoal = value["goal"] as? String{
            
            self.goal = weightGoal
            
        }else{
            
             self.goal = ""
        }
        
        if let protein = value["proteinToday"] as? Int{
            
            self.proteinToday = protein
            
        }else{
            
            self.proteinToday = 0
        }
        
        if let fat = value["fatToday"] as? Int{
            
            self.fatToday = fat
            
        }else{
            
            self.fatToday = 0
        }
        
        if let carb = value["carbToday"] as? Int{
            
            self.carbToday = carb
            
        }else{
            
            self.carbToday = 0
        }
        
        self.calorieCalc()
        self.macronutrientCalc()
        
        print("created user from user dafaults")
        
    }

    
    
    func toAnyObject() -> [String: Any] {
        return ["name": self.name, "age": self.age, "gender": self.gender, "height": self.height, "weight": self.weight, "activityLevel": self.activityLevel, "goal": self.goal, "proteinToday": self.proteinToday, "fatToday": self.fatToday, "carbToday": self.carbToday]
    }
    
    
    func addMealToFavorite(mealEaten: GenericFoodItem)
    {
        favoriteLog.append(mealEaten)
        
    }
    
    
    // add custom meal
    func addCustomMeal(itemName: String, itemDescription: String?, fats: Double?, proteins: Double?, carbs: Double?) {
        
        let customItem: GenericFoodItem! = GenericFoodItem(itemName: itemName, itemId: "custom", fats: fats!, proteins: proteins!, carbs: carbs!, foodSource: nil)
        customItem.imageUrl = ""
        customMealList.append(customItem) // add to custom meal log
    }
    
    func removeMealFromFavorite(mealEaten: GenericFoodItem)
    {
        for index in 0...favoriteLog.count{
            if favoriteLog[index].itemId == mealEaten.itemId{
                favoriteLog.remove(at: index)
                break
            }
        }
    }
    
    func removeMealFromLog(mealEaten: GenericFoodItem)
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
        
        
        if gender == "male" || gender == "Male"{
            
            temp = 66 + (6.2 * Double(weight))
            temp = temp + (12.7 * convertedHeight) - (6.76 * Double(age))
            calorieCount = activityLvl(bmr: temp)
            
        }else{
            
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
    
    func addMealToLog(mealEaten: GenericFoodItem) {
        mealLog.append(mealEaten)
        
        proteinToday = proteinToday + Int(mealEaten.proteins)
        carbToday = carbToday + Int(mealEaten.carbs)
        fatToday = fatToday + Int(mealEaten.fats)
        
        if let user = FIRAuth.auth()?.currentUser{
            
            let proteinRef = FIRDatabase.database().reference().child("users").child(user.uid).child("proteinToday")
            proteinRef.setValue(self.proteinToday)
            
            let carbRef = FIRDatabase.database().reference().child("users").child(user.uid).child("carbToday")
            carbRef.setValue(self.carbToday)
            
            let fatRef = FIRDatabase.database().reference().child("users").child(user.uid).child("fatToday")
            fatRef.setValue(self.fatToday)
        }
        
        UserDefaults.standard.set(self.toAnyObject(), forKey: "currentUser")
        
        print("prot: \(proteinToday), carb: \(carbToday), fat: \(fatToday)")
    }
    
}
