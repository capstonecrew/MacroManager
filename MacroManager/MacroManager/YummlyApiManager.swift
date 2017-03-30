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
        let request = YummlyRouter.search(query: query, count: count)
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
