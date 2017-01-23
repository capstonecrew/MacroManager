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
    
    var mealLog = [NixItem]() // meal history
    
    
    func addMealToLog(mealEaten: NixItem) {
        mealLog.append(mealEaten)
    }
    
}
