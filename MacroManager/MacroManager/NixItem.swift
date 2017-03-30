//
//  NixItem.swift
//  MacroManager
//
//  Created by user122708 on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import Foundation

struct NutrientDetail {
    var name : String = ""
    var amount : Double = 0
    var units : String = ""
}

class NixItem {
    var itemName : String
    var itemId : String
    var itemDescription : String?
    var fats : Double?
    var proteins : Double?
    var carbs : Double?
    var imageUrl: String?
    
    //Misc variables
    var miscNutrients : [NutrientDetail] = []
    
    required init?(itemName: String, itemId: String, itemDescription: String?, fats: Double?, proteins: Double?, carbs: Double?) {
        self.itemName = itemName
        self.itemId = itemId
        self.itemDescription = itemDescription
        self.fats = fats
        self.proteins = proteins
        self.carbs = carbs
    }
    
    convenience init?(json: [String: Any]) {
        guard let fieldsDict = json["fields"] as? [String: Any]
            else {
                return nil
        }
        
        guard let itemId = fieldsDict["item_id"] as? String,
            let itemName = fieldsDict["item_name"] as? String
            else {
                return nil
        }
        
        //Optionals
        let itemDescription = fieldsDict["item_description"] as? String
        let fats = fieldsDict["nf_total_fat"] as? Double
        let proteins = fieldsDict["nf_protein"] as? Double
        let carbs = fieldsDict["nf_total_carbohydrate"] as? Double
        
        self.init(itemName: itemName, itemId: itemId, itemDescription: itemDescription, fats: fats, proteins: proteins, carbs: carbs)
        
        //Misc data
        if let calories = fieldsDict["nf_calories"] as? Double {
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
        }
    }
    
    func toAnyObject() -> [String: Any]{
        
        return ["itemName": self.itemName, "itemId": self.itemId, "itemDescription": self.itemDescription ?? "", "fats": self.fats ?? 0.0, "carbs": self.carbs ?? 0.0, "proteins": self.proteins ?? 0.0]
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
