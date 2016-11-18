//
//  NixApiManager.swift
//  MacroManager
//
//  Created by user122708 on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import Foundation
import Alamofire

class NixApiManager {
    class func search(query: String, page: Int, completionHandler: @escaping (Result<[NixItem]>) -> Void) {
        let request = NixRouter.search(query: query, page: page)
        var items: [NixItem] = []
        
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
                let hits = json!["hits"] as! NSArray
                
                //Extract array of hits from JSON
                for item in hits {
                    if let newNixItem: NixItem = NixItem(json: item as! [String : Any]) {
                        items.append(newNixItem)
                    }
                }
                
                completionHandler(.success(items))
        }
    }
}
