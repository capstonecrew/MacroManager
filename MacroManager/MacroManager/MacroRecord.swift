//
//  MacroRecord.swift
//  MacroManager
//
//  Created by Alex Schultz on 3/30/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation

class MacroRecord: NSObject {
    let date: TimeInterval!
    var proteinToday: Int!
    var carbToday: Int!
    var fatToday: Int!
    var proteinGoal: Int!
    var carbGoal: Int!
    var fatGoal: Int!
    
    
    init(proteinGoal: Int!, carbGoal: Int!, fatGoal: Int!) {
        self.proteinToday = 0
        self.carbToday = 0
        self.fatToday = 0
        self.proteinGoal = proteinGoal
        self.carbGoal = carbGoal
        self.fatGoal = fatGoal
        
        self.date = Date().timeIntervalSince1970
    }
    
    init(dict: [String: Any]) {
        if let d = dict["date"] as? TimeInterval {
            self.date = d
        }
        else {
            self.date = Date().timeIntervalSince1970
        }
        if  let pt = dict["proteinToday"] as? Int! {
            self.proteinToday = pt
        }
        if let ct = dict["carbToday"] as? Int! {
            self.carbToday = ct
        }
        if let ft = dict["fatToday"] as? Int! {
            self.fatToday = ft
        }
        if let pg = dict["proteinGoal"] as? Int! {
            self.proteinGoal = pg
        }
        if let cg = dict["carbGoal"] as? Int! {
            self.carbGoal = cg
        }
        if let fg = dict["fatGoal"] as? Int! {
            self.fatGoal = fg
        }
    }
    
    func addMealToMacroRecord(mealEaten: GenericFoodItem) {
        self.proteinToday += mealEaten.proteins
        self.carbToday += mealEaten.carbs
        
    }
    
}
