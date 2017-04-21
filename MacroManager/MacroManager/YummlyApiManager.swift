//
//  YummlyApiManager.swift
//  MacroManager
//
//  Created by Aaron Edwards on 3/29/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import Foundation
import Alamofire

class YummlyApiManager {
    class func search(query: String, count: Int, completionHandler: @escaping (Result<[GenericFoodItem]>) -> Void) {
        let request = YummlyRouter.search(query: query, count: count, miscParams: nil)
        var items: [GenericFoodItem] = []
        
        Alamofire.request(request)
            .responseJSON { response in
                // Check HTTP errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling \(request.method) on \(request.path)")
                    print(response.result.error!)
                    return
                }
                
                // Validate JSON response
                //TODO error handling here
                let json = response.result.value as? [String: Any]
                let matches = json?["matches"] as? NSArray
                
                let lookupGroup = DispatchGroup()
                
                for match in matches!{
                    
                    lookupGroup.enter()
                    
                    let m = match as! [String: Any]
                    let id = m["id"] as! String
                    
                    let idRequest = YummlyRouter.getItem(id: id)
                    
                    Alamofire.request(idRequest).responseJSON { response in
                        
                        guard response.result.error == nil else {
                            // got an error in getting the data, need to handle it
                            print("error calling \(request.method) on \(request.path)")
                            print(response.result.error!)
                            lookupGroup.leave()
                            return
                        }
                        
                        let json = response.result.value as? [String: Any]
                        
                        if let item : GenericFoodItem = GenericFoodItem(json: json!, foodSource: .yummly){
                            
                            items.append(item)
                        }
                        
                        lookupGroup.leave()
                    }
                }
                
                lookupGroup.notify(queue: .main, execute: {
                    
                    completionHandler(.success(items))
                })
        }
    }
    
    class func percentSearch(query: String, count: Int, percent: Double, carbCount: Double, proteinCount: Double, fatCount: Double, completionHandler: @escaping (Result<[GenericFoodItem]>) -> Void) {
        //Build filter
        var filter: [String: Any] = [:]
        
        filter["nutrition.CHOCDF.min"] = (100.0 - percent)/100.0 * carbCount
        filter["nutrition.CHOCDF.max"] = (100.0 + percent)/100.0 * carbCount
        filter["nutrition.PROCNT.min"] = (100.0 - percent)/100.0 * proteinCount
        filter["nutrition.PROCNT.max"] = (100.0 + percent)/100.0 * proteinCount
        filter["nutrition.FAT.min"] = (100.0 - percent)/100.0 * fatCount
        filter["nutrition.FAT.max"] = (100.0 + percent)/100.0 * fatCount
        
        let request = YummlyRouter.search(query: query, count: count, miscParams: filter)
        var items: [GenericFoodItem] = []
        
        Alamofire.request(request)
            .responseJSON { response in
                // Check HTTP errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling \(request.method) on \(request.path)")
                    print(response.result.error!)
                    return
                }
                
                // Validate JSON response
                //TODO error handling here
                let json = response.result.value as? [String: Any]
                let matches = json?["matches"] as? NSArray
                
                let lookupGroup = DispatchGroup()
                
                for match in matches!{
                    
                    lookupGroup.enter()
                    
                    let m = match as! [String: Any]
                    let id = m["id"] as! String
                    
                    let idRequest = YummlyRouter.getItem(id: id)
                    
                    Alamofire.request(idRequest).responseJSON { response in
                        
                        guard response.result.error == nil else {
                            // got an error in getting the data, need to handle it
                            print("error calling \(request.method) on \(request.path)")
                            print(response.result.error!)
                            lookupGroup.leave()
                            return
                        }
                        
                        let json = response.result.value as? [String: Any]
                        
                        if let item : GenericFoodItem = GenericFoodItem(json: json!, foodSource: .yummly){
                            
                            items.append(item)
                        }
                        
                        lookupGroup.leave()
                    }
                }
                
                lookupGroup.notify(queue: .main, execute: {
                    
                    completionHandler(.success(items))
                })
        }
    }
}
