//
//  NixItem.swift
//  MacroManager
//
//  Created by user122708 on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import Foundation

class RecipeItem {
    var itemName : String
    var fats : Double?
    var proteins : Double?
    var carbs : Double?
    var imageUrl: String?
    
    //Misc variables
    //var miscNutrients : [NutrientDetail] = []
    
    required init?(itemName: String, fats: Double?, proteins: Double?, carbs: Double?, imageUrl: String) {
        self.itemName = itemName
        self.fats = fats
        self.proteins = proteins
        self.carbs = carbs
        self.imageUrl = imageUrl
    }
    
    convenience init?(json: [String: Any]) {
        guard let fieldsDict = json["recipe"] as? [String: Any]
            else {
                return nil
        }
        
        guard let itemName = fieldsDict["label"] as? String
            else {
                return nil
        }
        
        guard let image = fieldsDict["image"] as? String
            else {
                return nil
        }
        
        guard let yield = fieldsDict["yield"] as? Double
            else {
                return nil
        }
        
        guard let nutrients = fieldsDict["totalNutrients"] as? [String: Any]
            else {
                return nil
        }
        
        guard let fatDetails = nutrients["FAT"] as? [String: Any]
            else {
                return nil
        }
        
        guard let carbDetails = nutrients["CHOCDF"] as? [String: Any]
            else {
                return nil
        }
        
        guard let proteinDetails = nutrients["PROCNT"] as? [String: Any]
            else {
                return nil
        }
        
        //Optionals

        let proteins = (proteinDetails["quantity"] as? Double)!/yield
        let carbs = (carbDetails["quantity"] as? Double)! / yield
        let fats = (fatDetails["quantity"] as? Double)! / yield
        
        self.init(itemName: itemName, fats: fats, proteins: proteins, carbs: carbs, imageUrl: image)
        
//        //Misc data
//        if let calories = fieldsDict["nf_calories"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Calories", amount: calories, units: "kcal"))
//        }
//        if let cholesterol = fieldsDict["nf_cholesterol"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Cholesterol", amount: cholesterol, units: "mg"))
//        }
//        if let sodium = fieldsDict["nf_sodium"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Sodium", amount: sodium, units: "mg"))
//        }
//        if let fiber = fieldsDict["nf_dietary"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Fiber", amount: fiber, units: "g"))
//        }
//        if let sugars = fieldsDict["nf_sugars"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Sugars", amount: sugars, units: "g"))
//        }
//        if let vitaminA = fieldsDict["nf_vitamin_a_dv"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Vitamin A", amount: vitaminA, units: "%"))
//        }
//        if let vitaminC = fieldsDict["nf_vitamin_c_dv"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Vitamin C", amount: vitaminC, units: "%"))
//        }
//        if let calcium = fieldsDict["nf_calcium_dv"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Calcium", amount: calcium, units: "%"))
//        }
//        if let iron = fieldsDict["nf_iron_dv"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Iron", amount: iron, units: "%"))
//            
//        }
//        if let potassium = fieldsDict["nf_potassium"] as? Double {
//            self.miscNutrients.append(NutrientDetail(name: "Potassium", amount: potassium, units: "mg"))
//        }
    }
    
    func toString() -> String {
        return "Item Name: \(self.itemName)\n" +
            "Fats: \(self.fats) grams\n" +
            "Protein: \(self.proteins) grams\n" +
            "Carbs: \(self.carbs) grams\n" +
            "Image Url: \(self.imageUrl)"
    }
}
