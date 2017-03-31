//
//  GenericFoodItem.swift
//  MacroManager
//
//  Created by user122708 on 3/29/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation

struct NutrientDetail {
    var name : String = ""
    var amount : Double = 0
    var units : String = ""
}

enum FoodSource {
    case edamam
    case yummly
    case custom // for custom meals
}

class GenericFoodItem {
    var itemName : String!
    var itemId : String!
    var itemDescription : String = ""
    var fats : Int!
    var proteins : Int!
    var carbs : Int!
    var imageUrl: String = ""
    var foodSource : FoodSource!
    
    //Misc variables
    var miscNutrients : [NutrientDetail] = []
    
    required init(itemName: String, itemId: String, fats: Int, proteins: Int, carbs: Int, foodSource : FoodSource) {
        self.itemName = itemName
        self.itemId = itemId
        self.fats = fats
        self.proteins = proteins
        self.carbs = carbs
        self.foodSource = foodSource
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
            
            guard let itemId = fieldsDict["uri"] as? String
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
            
            let proteins = Double((proteinDetails["quantity"] as? Int)!)/yield
            let carbs = Double((carbDetails["quantity"] as? Int)!) / yield
            let fats = Double((fatDetails["quantity"] as? Int)!) / yield
            
            self.init(itemName: itemName, itemId: itemId, fats: Int(fats), proteins: Int(proteins), carbs: Int(carbs), foodSource: FoodSource.edamam)
            
            self.imageUrl = image
            
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
            
            guard let yield = json["numberOfServings"] as? Int
                else {
                    return nil
            }
            
            guard let nutrients = json["nutritionEstimates"] as? NSArray
                else {
                    return nil
            }
            
            // Loop through array of nutrition estimates and match on names
            var fats : Int?
            var carbs : Int?
            var proteins : Int?
            
            if nutrients.count > 0{
                
                for i in 0...nutrients.count - 1 {
                    guard let nutrient = nutrients[i] as? [String: Any]
                        else {
                            continue
                    }
                    
                    // Required data
                    if nutrient["attribute"] as! String == "FAT" {
                        guard let fatsVar = nutrient["value"] as! Int? else {
                            return nil
                        }
                        fats = fatsVar/yield
                    }
                    if nutrient["attribute"] as! String == "CHOCDF" {
                        guard let carbsVar = nutrient["value"] as! Int? else {
                            return nil
                        }
                        carbs = carbsVar/yield
                    }
                    if nutrient["attribute"] as! String == "PROCNT" {
                        guard let proteinsVar = nutrient["value"] as! Int? else {
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
            
        default:
            break
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
