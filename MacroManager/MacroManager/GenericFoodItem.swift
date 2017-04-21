//
//  GenericFoodItem.swift
//  MacroManager
//
//  Created by user122708 on 3/29/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation
import Firebase

struct NutrientDetail {
    var name : String = ""
    var amount : Double = 0
    var units : String = ""
}

enum FoodSource {
    case edamam
    case yummly
}

enum Quality {
    case good
    case okay
    case bad
    case uninitialized
}

class GenericFoodItem {
    var itemName : String
    var itemId : String
    var itemDescription : String = ""
    var fats : Double
    var proteins : Double
    var carbs : Double
    var imageUrl: String = ""
    var foodSource : FoodSource?
    var quality : Quality = .uninitialized
    
    //Misc variables
    var miscNutrients : [NutrientDetail] = []
    
    required init?(itemName: String, itemId: String, fats: Double, proteins: Double, carbs: Double, foodSource : FoodSource?) {
        self.itemName = itemName
        self.itemId = itemId
        self.fats = fats
        self.proteins = proteins
        self.carbs = carbs
        
        if let source = foodSource{
            
            self.foodSource = source
            
        }else{
            
            self.foodSource = nil
        }
    }
    init(snap: FIRDataSnapshot)
    {
        //super.init()
        let value = snap.value as? NSDictionary
        
        if let c = value!["carbs"] as? Double{
            self.carbs = c
        }
        else{
            self.carbs = 0.0
        }
        if let f = value!["fats"] as? Double{
            self.fats = f
        }
        else{
            self.fats = 0.0
        }
        if let p = value!["proteins"] as? Double{
            self.proteins = p
        }
        else{
            self.proteins = 0.0
        }
        if let i = value!["image"] as? String{
            self.imageUrl = i
        }
        else{
            self.imageUrl = ""
        }
        
        if let description = value!["imageDescription"] as? String{
            self.itemDescription = description
            
        }
        else{
            self.itemDescription = ""
            
        }
        
        if let iId = value!["itemId"] as? String
        {
            self.itemId = iId
        }
        else{
            self.itemId = ""
        }
        if let iName = value!["itemName"] as? String
        {
            self.itemName = iName
            
        }
        else{
            self.itemName = ""
        }
    }
    
    

    convenience init?(json: [String: Any], foodSource : FoodSource) {
        switch foodSource {
        case FoodSource.edamam:
            guard let fieldsDict = json["recipe"] as? [String: Any]
                else {
                    return nil
            }
            
            guard let itemName = fieldsDict["label"] as? String
                else {
                    return nil
            }
            
            guard let id = fieldsDict["uri"] as? String
                else {
                    return nil
            }
            
            var identifier = id.replacingOccurrences(of: ".", with: "0")
            identifier = identifier.replacingOccurrences(of: "$", with: "0")
            identifier = identifier.replacingOccurrences(of: "[", with: "0")
            identifier = identifier.replacingOccurrences(of: "]", with: "0")
            identifier = identifier.replacingOccurrences(of: "#", with: "0")
            identifier = identifier.replacingOccurrences(of: "/", with: "0")
            
            print(identifier)
        
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
            
            let proteins = (proteinDetails["quantity"] as? Double)!/yield
            let carbs = (carbDetails["quantity"] as? Double)! / yield
            let fats = (fatDetails["quantity"] as? Double)! / yield
            
            self.init(itemName: itemName, itemId: identifier, fats: fats, proteins: proteins, carbs: carbs, foodSource: FoodSource.edamam)
            
            self.imageUrl = image
            
            //Misc data
            for item in nutrients{
                if (item.key == "FAT" || item.key == "CHOCDF" || item.key == "PROCNT"){
                    continue
                }
                
                if let itemDetails = item.value as? [String: Any] {
                    self.miscNutrients.append(NutrientDetail(name: (itemDetails["label"] as? String)!, amount: (itemDetails["quantity"] as? Double)!/yield, units: (itemDetails["unit"] as? String)!))
                }
            }
            /*
            if let calories = nutrients["ENERC_KCAL"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Calories", amount: (calories["quantity"] as? Double)!/yield, units: "kcal"))
            }
            if let cholesterol = nutrients["CHOLE"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Cholesterol", amount: (cholesterol["quantity"] as? Double)!/yield, units: "mg"))
            }
            if let sodium = nutrients["NA"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Sodium", amount: (sodium["quantity"] as? Double)!/yield, units: "mg"))
            }
            if let fiber = nutrients["FIBTG"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Fiber", amount: (fiber["quantity"] as? Double)!/yield, units: "g"))
            }
            if let sugars = nutrients["SUGAR"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Sugars", amount: (sugars["quantity"] as? Double)!/yield, units: "g"))
            }
            if let vitaminA = nutrients["VITA_RAE"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Vitamin A", amount: (vitaminA["quantity"] as? Double)!/yield, units: "ug"))
            }
            if let vitaminC = nutrients["VITC"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Vitamin C", amount: (vitaminC["quantity"] as? Double)!/yield, units: "mg"))
            }
            if let calcium = nutrients["nf_calcium_dv"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Calcium", amount: calcium, units: "%"))
            }
            if let iron = nutrients["nf_iron_dv"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Iron", amount: iron, units: "%"))
                
            }
            if let potassium = nutrients["nf_potassium"] as? [String: Any] {
                self.miscNutrients.append(NutrientDetail(name: "Potassium", amount: potassium, units: "mg"))
            }*/
            
        case FoodSource.yummly:
            guard let itemName = json["name"] as? String
                else {
                    return nil
            }
            
            guard let itemId = json["id"] as? String
                else {
                    return nil
            }
            
            guard let images = json["images"] as? NSArray
                else {
                    return nil
            }
            
            guard let imageDict = images[0] as? [String: Any]
                else {
                    return nil
            }
            
            guard let image = imageDict["hostedSmallUrl"] as? String
                else {
                    return nil
            }
            
            guard let yield = json["numberOfServings"] as? Double
                else {
                    return nil
            }
            
            guard let nutrients = json["nutritionEstimates"] as? NSArray
                else {
                    return nil
            }
            
            // Loop through array of nutrition estimates and match on names
            var fats : Double?
            var carbs : Double?
            var proteins : Double?
            
            if nutrients.count > 0{
                
                for i in 0...nutrients.count - 1 {
                    guard let nutrient = nutrients[i] as? [String: Any]
                        else {
                            continue
                    }
                    
                    // Required data
                    if nutrient["attribute"] as! String == "FAT" {
                        guard let fatsVar = nutrient["value"] as! Double? else {
                            return nil
                        }
                        fats = fatsVar/yield
                    }
                    if nutrient["attribute"] as! String == "CHOCDF" {
                        guard let carbsVar = nutrient["value"] as! Double? else {
                            return nil
                        }
                        carbs = carbsVar/yield
                    }
                    if nutrient["attribute"] as! String == "PROCNT" {
                        guard let proteinsVar = nutrient["value"] as! Double? else {
                            return nil
                        }
                        proteins = proteinsVar/yield
                    }
                }

            }
            
            
            if (fats==nil || carbs==nil || proteins==nil) {
                return nil
            }
            
            self.init(itemName: itemName, itemId: itemId, fats: fats!, proteins: proteins!, carbs: carbs!, foodSource: FoodSource.edamam)
            
            self.imageUrl = image
            
            //Misc data
            /*if let calories = fieldsDict["nf_calories"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Calories", amount: calories, units: "kcal"))
             }
             if let cholesterol = fieldsDict["nf_cholesterol"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Cholesterol", amount: cholesterol, units: "mg"))
             }
             if let sodium = fieldsDict["nf_sodium"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Sodium", amount: sodium, units: "mg"))
             }
             if let fiber = fieldsDict["nf_dietary"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Fiber", amount: fiber, units: "g"))
             }
             if let sugars = fieldsDict["nf_sugars"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Sugars", amount: sugars, units: "g"))
             }
             if let vitaminA = fieldsDict["nf_vitamin_a_dv"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Vitamin A", amount: vitaminA, units: "%"))
             }
             if let vitaminC = fieldsDict["nf_vitamin_c_dv"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Vitamin C", amount: vitaminC, units: "%"))
             }
             if let calcium = fieldsDict["nf_calcium_dv"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Calcium", amount: calcium, units: "%"))
             }
             if let iron = fieldsDict["nf_iron_dv"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Iron", amount: iron, units: "%"))
             
             }
             if let potassium = fieldsDict["nf_potassium"] as? Double {
             self.miscNutrients.append(NutrientDetail(name: "Potassium", amount: potassium, units: "mg"))
             }*/
        }
    }
    
    func toAnyObject() -> [String: Any]{
        
        return ["itemName": self.itemName, "itemId": self.itemId, "itemDescription": self.itemDescription ?? "", "fats": self.fats ?? 0.0, "carbs": self.carbs ?? 0.0, "proteins": self.proteins ?? 0.0, "image": imageUrl]
    }
    
    func toString() -> String {
        return "Item Name: \(self.itemName)\n" +
            "Item ID: \(self.itemId)\n" +
            "Item Description: \(self.itemDescription)\n" +
            "Fats: \(self.fats) grams\n" +
            "Protein: \(self.proteins) grams\n" +
        "Carbs: \(self.carbs) grams\n"
    }
}
